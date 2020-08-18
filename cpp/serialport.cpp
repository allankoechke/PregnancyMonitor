#include "serialport.h"

SerialPort::SerialPort(QObject *parent) : QObject(parent)
{
    connect(m_serial_port, &QSerialPort::readyRead, this, &SerialPort::onReadyRead);
    connect(m_serial_port, &QSerialPort::errorOccurred, this, &SerialPort::onSerialPortDisconnected);
}

bool SerialPort::initializeSerialPort()
{
    foreach (const QSerialPortInfo &m_serialPortInfo, QSerialPortInfo::availablePorts())
    {
        if(m_serialPortInfo.portName().contains("ttyACM", Qt::CaseSensitive))
        {
            m_portName = m_serialPortInfo.portName();

            break;
        }

        if(m_portName != "")
        {
            m_serial_port->setPortName(m_portName);

            if(!m_serial_port->isOpen())
            {
                // Open port for Read and Write
                m_serial_port->open(QIODevice::ReadWrite);
            }

            m_serial_port->setBaudRate(QSerialPort::Baud115200);
            m_serial_port->setParity(QSerialPort::NoParity);
            m_serial_port->setDataBits(QSerialPort::Data8);
            m_serial_port->setStopBits(QSerialPort::OneStop);
            m_serial_port->setFlowControl(QSerialPort::NoFlowControl);

            return true;
        }

        else
        {
            emit emitSerialPortConnected();

            return false;
        }
    }

    return false;
}

void SerialPort::onSerialPortDisconnected()
{
    if(!m_serial_port->isOpen())
    {
        qDebug()<<"Serial Port is not open";
    }
}

void SerialPort::onReadyRead()
{

}

void SerialPort::onReadyWrite()
{

}
