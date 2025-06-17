#include "TemperatureController.h"
#include <QDebug>

TemperatureController::TemperatureController(TemperatureModel* model, QObject *parent)
    : QObject(parent), m_model(model) {}

void TemperatureController::updateFromCelsius(const QString &text) {
    bool ok;
    double val = text.toDouble(&ok);
    if (ok) {
        if (val < -273.15) {
            emit invalidInput("Celsius temperature cannot be below -273.15");
            return;
        }
        m_model->setCelsius(val);
    } else {
        emit invalidInput("Invalid input for Celsius");
    }
}

void TemperatureController::updateFromFahrenheit(const QString &text) {
    bool ok;
    double val = text.toDouble(&ok);
    if (ok) {
        if (val < -459.67) {
            emit invalidInput("Fahrenheit temperature cannot be below -459.67");
            return;
        }
        m_model->setFahrenheit(val);
    } else {
        emit invalidInput("Invalid input for Fahrenheit");
    }
}

void TemperatureController::updateFromKelvin(const QString &text) {
    bool ok;
    double val = text.toDouble(&ok);
    if (ok) {
        if (val < 0.0) {
            emit invalidInput("Kelvin temperature cannot be below 0");
            return;
        }
        m_model->setKelvin(val);
    } else {
        emit invalidInput("Invalid input for Kelvin");
    }
}
