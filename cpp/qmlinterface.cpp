#include "qmlinterface.h"

QmlInterface::QmlInterface(QObject *parent) : QObject(parent)
{
    qDebug()<< "CPP: QmlInterface initialized ...";
}

QVariant QmlInterface::hashPassword(QVariant password)
{
    m_password = QString(QCryptographicHash::hash((password.toByteArray()),QCryptographicHash::Md5).toHex());

    qDebug()<<"CPP: Password: "<<password.toString()<<"--"<<m_password;

    return QVariant::fromValue(m_password);
}

