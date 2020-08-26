#include "serialportinterface.h"

SerialPortInterface::SerialPortInterface(QObject *parent) : QObject(parent)
{
    m_serial_port = new QSerialPort(parent);

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

            if(segmentedData.length()!=0)
            {
                if(segmentedData.length()==1)
                {
                    emit statusDataRecieved(segmentedData.at(0));
                }

                if(segmentedData.length()==2)
                {
                    emit heartbeatDataRecieved(segmentedData.at(0).toFloat());

                    emit chartDataRecieved(segmentedData.at(1).toFloat());

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
