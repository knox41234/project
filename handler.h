#ifndef HANDLER_H
#define HANDLER_H

#include <QObject>
#include <QRect>
#include <QApplication>
#include <QDebug>
#include <QDesktopWidget>
#include <QScreen>
#include <QDir>
#include <QUrl>
#include <QList>
#include <QVariantList>


#include <QHttpMultiPart>

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkInterface>

class handler : public QObject
{
    Q_OBJECT
public:
    explicit handler(QObject *parent = nullptr);


    Q_INVOKABLE QString getRoomsWithStatusAPI() const;
    void setRoomsWithStatusAPI(const QString &value);

    Q_INVOKABLE QString getAddRoomsAPI() const;
    void setAddRoomsAPI(const QString &value);

    Q_INVOKABLE QString getEmployeeAPI() const;
    void setEmployeeAPI(const QString &value);

    Q_INVOKABLE int getWindowWidth() const;
    Q_INVOKABLE void setWindowWidth(int value);

    Q_INVOKABLE int getWindowHeight() const;
    Q_INVOKABLE void setWindowHeight(int value);

    Q_INVOKABLE void emitGlobalRefresh();

    Q_INVOKABLE QString getAddDepartmentAPI() const;
    void setAddDepartmentAPI(const QString &value);

    Q_INVOKABLE QString getDepartmentAPI() const;
    void setDepartmentAPI(const QString &value);

    Q_INVOKABLE QString getSubjectsAPI() const;
    void setSubjectsAPI(const QString &value);

    Q_INVOKABLE QString getSubjectsDataAPI() const;
    void setSubjectsDataAPI(const QString &value);

    Q_INVOKABLE QString getTeachersOnlyAPI() const;
    void setTeachersOnlyAPI(const QString &value);

    Q_INVOKABLE void postImages(QList<QUrl> urls);

    Q_INVOKABLE QString getFileNameFromPath(QUrl url);

    Q_INVOKABLE QString getAddScheduleAPI() const;
    void setAddScheduleAPI(const QString &value);

    Q_INVOKABLE QString getDateTimeAPI() const;
    void setDateTimeAPI(const QString &value);

    Q_INVOKABLE QString getAddEmployeeAPI() const;
    void setAddEmployeeAPI(const QString &value);

private:

    QString roomsWithStatusAPI = "https://project-concepcion-ira-lumagod.herokuapp.com/room/roomsWithStatus";

    QString employeeAPI = "https://project-concepcion-ira-lumagod.herokuapp.com/employee";

    QString addEmployeeAPI = "http://192.168.1.26:3000/employee";

    QString addRoomsAPI = "https://project-concepcion-ira-lumagod.herokuapp.com/room";

    QString addDepartmentAPI = "http://192.168.1.26:3000/department";

    QString departmentAPI = "https://project-concepcion-ira-lumagod.herokuapp.com/department";

    QString subjectsAPI = "https://project-concepcion-ira-lumagod.herokuapp.com/subject";

    QString subjectsDataAPI = "https://project-concepcion-ira-lumagod.herokuapp.com/subject/extendedData";

    QString teachersOnlyAPI = "https://project-concepcion-ira-lumagod.herokuapp.com/employee/teachers";

    QString sendImageAPI = "http://192.168.1.26:3000/imageUpload/newEmployeeImages";

    QString addScheduleAPI ="http://192.168.1.25:3000/schedule";

    QString dateTimeAPI = "http://192.168.1.26:3000/extra/getDateTime";

    int windowWidth;
    int windowHeight;

signals:

    void globalRefresh();

public slots:



};

#endif // HANDLER_H
