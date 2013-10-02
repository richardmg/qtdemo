#include <QGuiApplication>
#include <QtQml>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>
#include "shaderfilereader.h"

Q_IMPORT_PLUGIN(QtQuick2Plugin)
Q_IMPORT_PLUGIN(QtQuick2ParticlesPlugin)
Q_IMPORT_PLUGIN(QtQuick2WindowPlugin)
Q_IMPORT_PLUGIN(QmlXmlListModelPlugin)

int main(int argc, char *argv[])
{
    Q_INIT_RESOURCE(particles);

    QGuiApplication app(argc, argv);

    qputenv("QML2_IMPORT_PATH", "qml");

    QQuickView view(QUrl("qrc:/qml2/QtDemo/main.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);

    ShaderFileReader fileReader;
    view.rootContext()->setContextProperty("shaderFileReader", &fileReader);

    view.showFullScreen();

    return app.exec();
}
