#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QDebug>
#include <QSerialPort>
#include <QSerialPortInfo>

class SerialPort : public QObject
{
    Q_OBJECT

public:
    explicit SerialPort(QObject *parent = nullptr);

    bool initializeSerialPort();

    void onSerialPortDisconnected();

signals:
    void emitSerialPortConnected();

private slots:
    void onReadyRead();

    void onReadyWrite();

private:
    QSerialPort * m_serial_port;

    QSerialPortInfo * m_serialPortInfo;

    QString m_portName;

};

#endif // SERIALPORT_H
