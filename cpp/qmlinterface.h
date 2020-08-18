#ifndef QMLINTERFACE_H
#define QMLINTERFACE_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QCryptographicHash>

//#include "serialport.h"

class QmlInterface : public QObject
{
    Q_OBJECT
public:
    explicit QmlInterface(QObject *parent = nullptr);

    Q_INVOKABLE QVariant hashPassword(QVariant password);

signals:

private:
    QString m_password;

    //SerialPort m_serialPort;

};

#endif // QMLINTERFACE_H
