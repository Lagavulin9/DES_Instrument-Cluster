#ifndef MYINTERFACE_H
#define MYINTERFACE_H

#include <QObject>
#include <QDBusInterface>
#include <QDBusConnection>
#include <QDBusMessage>
#include <QDBusReply>
#include <QRandomGenerator>
#include <QTimer>
#include <QDebug>

#define CANNAME "com.example.canService"
#define CANPATH "/com/example/canService"
#define PIRACERNAME "com.example.piracerService"
#define PIRACERPATH "/com/example/piracerService"

class MyInterface : public QObject
{
    Q_OBJECT

public:
    explicit MyInterface(QObject *parent = nullptr);

    Q_PROPERTY(double speed READ getSpeed WRITE setSpeed NOTIFY speedChanged);
    Q_PROPERTY(double fuel READ getFuel WRITE setFuel NOTIFY fuelChanged);
    Q_PROPERTY(double dis READ getDis WRITE setDis NOTIFY disChanged);

    double getSpeed() const;
    double getFuel() const;
    double getDis() const;

public slots:
    void setSpeed(qreal speed);
    void setFuel(qreal fuel);
    void setDis(qreal dis);
    void fetchSpeed();

signals:
    void speedChanged(qreal speed);
    void fuelChanged(qreal fuel);
    void disChanged(qreal dis);

private:
    QDBusConnection m_bus;
    QDBusInterface* piracer_interface;
    QDBusInterface* can_interface;
    qreal m_speed;
    qreal m_fuel;
    qreal m_dis;
};

#endif // MYINTERFACE_H
