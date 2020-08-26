#include "qmlinterface.h"

QmlInterface::QmlInterface(QObject *parent) : QObject(parent)
{
    m_thread = new QThread(parent);

    m_serialPortinterface = new SerialPortInterface(m_thread);

    connect(m_thread,&QThread::finished,m_thread,&QObject::deleteLater);
    connect(m_thread,&QThread::finished,m_serialPortinterface,&QObject::deleteLater);

    connect(this,&QmlInterface::initSerializerPort,m_serialPortinterface,&SerialPortInterface::onInitSerializerPort);

    connect(m_serialPortinterface,&SerialPortInterface::startedSerializerPort,this,&QmlInterface::onStartedSerializerPort);

    connect(this,&QmlInterface::sendingData,m_serialPortinterface,&SerialPortInterface::onSendingData);

    connect(m_serialPortinterface,&SerialPortInterface::sentData,this,&QmlInterface::onSentData);

    connect(m_serialPortinterface,&SerialPortInterface::heartbeatDataRecieved,this,&QmlInterface::onheartBeatDataRecieved);

    connect(m_serialPortinterface,&SerialPortInterface::statusDataRecieved,this,&QmlInterface::onStatusDataRecieved);

    connect(m_serialPortinterface,&SerialPortInterface::chartDataRecieved,this,&QmlInterface::onChartDataRecieved);

    connect(this, &QmlInterface::plotDataChanged, this, &QmlInterface::onPlotDataChanged);
}

QVariant QmlInterface::hashPassword(QVariant password)
{
    m_password = QString(QCryptographicHash::hash((password.toByteArray()),QCryptographicHash::Md5).toHex());

    qDebug()<<"CPP: Password: "<<password.toString()<<"--"<<m_password;

    return QVariant::fromValue(m_password);
}

void QmlInterface::startSerialPort()
{
    if(m_thread->isRunning())
        emit initSerializerPort();

    else
    {
        m_thread->start();

        emit initSerializerPort();
    }
}

QVariantList QmlInterface::getChartData()
{
    // Return the QvariantList data for plotting
    return m_plotData;
}

void QmlInterface::takeMeasurements(bool status)
{
    m_isTakingMeasurents = status;

    if(!m_isTakingMeasurents)
    {
        m_plotData.clear();
    }
}

bool QmlInterface::isMeasuring()
{
    return m_isTakingMeasurents;
}

void QmlInterface::onStatusDataRecieved(QString data)
{
    qDebug()<<"data: "<<data;
}

void QmlInterface::onheartBeatDataRecieved(float data)
{
    emit emitHeartBeatDataReceived(data);
}

void QmlInterface::onSentData(bool state)
{
    qDebug()<<"Data sent sucessfully: "<< state;
}

void QmlInterface::onStartedSerializerPort(bool state)
{
    qDebug()<<"Serial Port opended: "<< state;
}

void QmlInterface::onChartDataRecieved(float data)
{
    // Check if array has more than 100 entries,
    // If more, remove the first item before appending
    // the new item

    if(m_isTakingMeasurents) // If measuring has started
    {

        if(m_plotData.length() == 30)
        {
            m_plotData.removeFirst();
        }

        m_plotData.append(data);

        emit plotDataChanged();
    }
}

void QmlInterface::onPlotDataChanged()
{
    emit emitPlotDataChanged(m_plotData);
}

