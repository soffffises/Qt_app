#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "TemperatureModel.h"
#include "TemperatureController.h"

int main(int argc, char *argv[]) {

    QQuickStyle::setStyle("Fusion");

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    TemperatureModel model;
    TemperatureController controller(&model);

    engine.rootContext()->setContextProperty("temperatureModel", &model);
    engine.rootContext()->setContextProperty("temperatureController", &controller);

    engine.load(QUrl::fromLocalFile("D:/Qt/homework/Main.qml"));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
