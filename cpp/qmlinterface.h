#ifndef QMLINTERFACE_H
#define QMLINTERFACE_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QThread>
#include <QVariantList>
#include <QCryptographicHash>

#include "serialportinterface.h"

class QmlInterface : public QObject
{
    Q_OBJECT
public:
    explicit QmlInterface(QObject *parent = nullptr);

    Q_PROPERTY(QVariantList plotData MEMBER m_plotData NOTIFY plotDataChanged)

    Q_PROPERTY(bool isMeasuring MEMBER m_isTakingMeasurents NOTIFY isTakingMeasurentsChanged);

    Q_PROPERTY(float plotX MEMBER m_plot_x);

    Q_INVOKABLE QVariant hashPassword(QVariant password);

    Q_INVOKABLE void startSerialPort();

    Q_INVOKABLE QVariantList getChartData();

    Q_INVOKABLE void takeMeasurements(bool status);

    bool isMeasuring();

signals:
    void sendingData(QVariantList data);

    void initSerializerPort();

    void plotDataChanged();

    void isTakingMeasurentsChanged();

    // Emitted signals to be handled in QML

    void emitPlotDataChanged(QVariantList data);

    void emitHeartBeatDataReceived(float data);

    void emitChartData(float x, float data);

    void clearChart();

public  slots:
    void onStatusDataRecieved(QString data);

    void onheartBeatDataRecieved(float data);

    void onSentData(bool state);

    void onStartedSerializerPort(bool state);

    void onChartDataRecieved(float data);

    void onPlotDataChanged();

private:
    QString m_password;

    QThread * m_thread;

    QVariantList m_plotData;

    bool m_isTakingMeasurents = false;

    SerialPortInterface * m_serialPortinterface;

    float m_plot_x;

};

#endif // QMLINTERFACE_H
