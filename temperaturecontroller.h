#ifndef TEMPERATURECONTROLLER_H
#define TEMPERATURECONTROLLER_H

#include <QObject>
#include "TemperatureModel.h"

class TemperatureController : public QObject {
    Q_OBJECT
public:
    explicit TemperatureController(TemperatureModel* model, QObject *parent = nullptr);

    Q_INVOKABLE void updateFromCelsius(const QString &text);
    Q_INVOKABLE void updateFromFahrenheit(const QString &text);
    Q_INVOKABLE void updateFromKelvin(const QString &text);

signals:
    void invalidInput(const QString &scale);

private:
    TemperatureModel* m_model;
};

#endif
