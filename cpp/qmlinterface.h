#ifndef QMLINTERFACE_H
#define QMLINTERFACE_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QCryptographicHash>

class QmlInterface : public QObject
{
    Q_OBJECT
public:
    explicit QmlInterface(QObject *parent = nullptr);

    Q_INVOKABLE QVariant hashPassword(QVariant password);

signals:

private:
    QString m_password;

};

#endif // QMLINTERFACE_H
