#include "serialportinterface.h"

SerialPortInterface::SerialPortInterface(QObject *parent) : QObject(parent)
{
    m_serial_port = new QSerialPort(parent);

    std::fstream afile;

    afile.open("/home/lalan-ke/Documents/QML/PregnancyMonitor/assets/out.txt", std::ios::in);

    std::string line;

    qDebug() << "File opened? " << afile.is_open();

    if (afile.is_open())
    {
        while ( std::getline (afile,line) )
        {
            m_plot_data.append(std::stof(line));

            // qDebug()<<std::stof(line);
        }
        afile.close();

        m_array_size = m_plot_data.size();
    }

    timer =  new QTimer(this);

    connect(timer, &QTimer::timeout, this, &SerialPortInterface::onTimerOverflow);

    timer->start(3);

    connect(m_serial_port,&QSerialPort::readyRead,this,&SerialPortInterface::onReadyRead);

    connect(m_serial_port,&QSerialPort::errorOccurred,this,&SerialPortInterface::checkIfSerialPortIsConnected);
}

bool SerialPortInterface::initializeSerialPort()
{
    m_port_name="";

    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts())
    {
        qDebug()<<"Identifier: "<<serialPortInfo.hasVendorIdentifier()<<"Product Identifier: "<<serialPortInfo.hasProductIdentifier()<<"Port Name: "<<serialPortInfo.portName();

        if(serialPortInfo.portName().contains("ttyACM", Qt::CaseSensitive))
        {
            m_port_name = serialPortInfo.portName();

            break;
        }
    }

    if(m_port_name.length()>0)
    {
        m_serial_port->setPortName(m_port_name);

        if(!m_serial_port->isOpen())
        {
            m_is_available=m_serial_port->open(QSerialPort::ReadWrite);
        }
        else
        {
            m_serial_port->close();

            m_is_available=m_serial_port->open(QSerialPort::ReadWrite);
        }

        if(m_is_available)
        {
            m_serial_port->setBaudRate(QSerialPort::Baud115200, QSerialPort::AllDirections);
            m_serial_port->setDataBits(QSerialPort::Data8);
            m_serial_port->setParity(QSerialPort::NoParity);
            m_serial_port->setStopBits(QSerialPort::OneStop);
            m_serial_port->setFlowControl(QSerialPort::NoFlowControl);

            return true;
        }

        return false;
    }

    return false;
}

bool SerialPortInterface::sendData(QVariantList data)
{
    if(m_serial_port->isOpen())
    {
        qDebug()<<"Sent: "<<prepareDataForSending(data);

        m_serial_port->write(prepareDataForSending(data));

        return true;
    }
    else
    {
        return false;
    }
}

void SerialPortInterface::onInitSerializerPort()
{
    emit startedSerializerPort(initializeSerialPort());
}

void SerialPortInterface::onTimerOverflow()
{
    // qDebug()<<"Here ..." << index;

    if(m_array_size > 0)
    {
        emit chartDataRecieved(m_plot_data[index]);

        index ++;

        if(index >= m_array_size)
        {
            index = 0;
        }
    }
}

void SerialPortInterface::onSendingData(QVariantList data)
{
    emit sentData(sendData(data));
}

void SerialPortInterface::onReadyRead()
{
    QString data=QString::fromUtf8(m_serial_port->readAll());

    QStringList dataSplit = data.split("\r\n");

    foreach(QString d,dataSplit)
    {
        if(d.length()>0)
        {
            QStringList segmentedData=d.split(":");

            qDebug()<< d;

            if(segmentedData.length()!=0)
            {
                if(segmentedData.length()==1)
                {
                    //emit statusDataRecieved(segmentedData.at(0));
                    qDebug() << segmentedData.at(0);
                    //emit chartDataRecieved(segmentedData.at(0).toFloat());
                }

                if(segmentedData.length()==2)
                {
                    emit heartbeatDataRecieved(segmentedData.at(1).toFloat());

                    //emit chartDataRecieved(segmentedData.at(0).toFloat());

                    qDebug()<<"Data: --> "<<segmentedData.at(0).toFloat()<<"\t"<<segmentedData.at(1).toFloat();
                }
            }

        }
    }
}

void SerialPortInterface::checkIfSerialPortIsConnected(QSerialPort::SerialPortError error)
{
    if(error!=QSerialPort::NoError)
    {
        m_serial_port->close();

        qDebug()<<"Error: "<<error;

        startedSerializerPort(m_serial_port->isOpen());
    }
}

QByteArray SerialPortInterface::prepareDataForSending(QVariantList data)
{
    QByteArray dataQByteArray;

    foreach(QVariant value,data)
    {
        dataQByteArray.append(QByteArray::fromHex(value.toByteArray()),1);

    }

    return dataQByteArray;
}
