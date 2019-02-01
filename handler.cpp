#include "handler.h"

handler::handler(QObject *parent) : QObject(parent)
{

}

QString handler::getRoomsWithStatusAPI() const
{
    return roomsWithStatusAPI;
}

void handler::setRoomsWithStatusAPI(const QString &value)
{
    roomsWithStatusAPI = value;
}

QString handler::getAddRoomsAPI() const
{
    return addRoomsAPI;
}

void handler::setAddRoomsAPI(const QString &value)
{
    addRoomsAPI = value;
}

QString handler::getEmployeeAPI() const
{
    return employeeAPI;
}

void handler::setEmployeeAPI(const QString &value)
{
    employeeAPI = value;
}

int handler::getWindowWidth() const
{
    return windowWidth;
}

void handler::setWindowWidth(int value)
{
    windowWidth = value;
}

int handler::getWindowHeight() const
{
    return windowHeight;
}

void handler::setWindowHeight(int value)
{
    windowHeight = value;
}

void handler::emitGlobalRefresh()
{
    emit globalRefresh();
}

QString handler::getAddDepartmentAPI() const
{
    return addDepartmentAPI;
}

void handler::setAddDepartmentAPI(const QString &value)
{
    addDepartmentAPI = value;
}

QString handler::getDepartmentAPI() const
{
    return departmentAPI;
}

void handler::setDepartmentAPI(const QString &value)
{
    departmentAPI = value;
}

QString handler::getSubjectsAPI() const
{
    return subjectsAPI;
}

void handler::setSubjectsAPI(const QString &value)
{
    subjectsAPI = value;
}

QString handler::getSubjectsDataAPI() const
{
    return subjectsDataAPI;
}

void handler::setSubjectsDataAPI(const QString &value)
{
    subjectsDataAPI = value;
}

QString handler::getTeachersOnlyAPI() const
{
    return teachersOnlyAPI;
}

void handler::setTeachersOnlyAPI(const QString &value)
{
    teachersOnlyAPI = value;
}

void handler::postImages(QList<QUrl>  urls)
{

    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);
    multiPart->setBoundary("----WebKitFormBoundary7MA4YWxkTrZu0gW");


    QList<QFile *>   files;
    QList<QHttpPart> fileparts;

//            qDebug()<<urls.length();

    for(int i=0;i<urls.length();i++)
    {
        QFile * tempfile = new QFile(urls[i].toLocalFile());

        tempfile->open(QIODevice::ReadOnly);

//        qDebug()<<urls[i].toLocalFile();

        files.append((tempfile));
    }

    for(int i=0;i<urls.length();i++)
    {
            QHttpPart filePart;
            filePart.setHeader(QNetworkRequest::ContentDispositionHeader,QVariant("form-data; name=\"uploadImage\"; filename="+files[i]->fileName()));
            filePart.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("image/jpg"));   // file type header MIME type
            filePart.setBodyDevice(files[i]);

            fileparts.append(filePart);
    }


    for(int i=0;i<urls.length();i++)
            files[i]->setParent(multiPart);

    for(int i=0;i<urls.length();i++)
            multiPart->append(fileparts[i]);

    QNetworkRequest request((QUrl(sendImageAPI)));

    QNetworkAccessManager * manager = new QNetworkAccessManager();
    manager->post(request, multiPart);

    QObject::connect(manager, &QNetworkAccessManager::finished,
        this, [=](QNetworkReply *reply) {
            if (reply->error()) {
                qDebug() << reply->errorString();
                return;
            }

            QString answer = reply->readAll();

            qDebug() << answer;

            reply->abort();
            reply->deleteLater();
            reply->manager()->deleteLater();
        }
    );


    qDebug()<<"Function Finished";
}

QString handler::getFileNameFromPath(QUrl url)
{
    return url.fileName();
}

QString handler::getAddScheduleAPI() const
{
    return addScheduleAPI;
}

void handler::setAddScheduleAPI(const QString &value)
{
    addScheduleAPI = value;
}

QString handler::getDateTimeAPI() const
{
    return dateTimeAPI;
}

void handler::setDateTimeAPI(const QString &value)
{
    dateTimeAPI = value;
}

QString handler::getAddEmployeeAPI() const
{
    return addEmployeeAPI;
}

void handler::setAddEmployeeAPI(const QString &value)
{
    addEmployeeAPI = value;
}


