#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "cpp/qmlinterface.h"

int main(int argc, char *argv[])
{
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    app.setOrganizationName("My Company Org");

    app.setOrganizationDomain("www.exampledomain.org");

    app.setApplicationName("Pregnancy Monitoring");

    QmlInterface qmlInteface;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("QmlInterface", &qmlInteface);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
