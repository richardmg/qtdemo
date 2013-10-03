TEMPLATE = app
contains(QT_CONFIG, release): CONFIG += release

QMAKE_INFO_PLIST = Info.plist
icons.files += Icon.png
QMAKE_BUNDLE_DATA += icons

QT += qml quick multimedia xmlpatterns
HEADERS += shaderfilereader.h
SOURCES += main.cpp shaderfilereader.cpp
RESOURCES += resources.qrc

qml2.files = qml2
QMAKE_BUNDLE_DATA += qml2

qmldir.files += $$[QT_INSTALL_QML]
QMAKE_BUNDLE_DATA += qmldir

QTDIR = /Volumes/Code/qt-src/qt-50-ios-dev/qtbase
LIBS += -L$$[QT_INSTALL_QML]/QtQuick.2 -lqtquick2plugin$$qtPlatformTargetSuffix()
LIBS += -L$$[QT_INSTALL_QML]/QtQuick/Window.2 -lwindowplugin$$qtPlatformTargetSuffix()
LIBS += -L$$[QT_INSTALL_QML]/QtQuick/Particles.2 -lparticlesplugin$$qtPlatformTargetSuffix()
LIBS += -L$$[QT_INSTALL_QML]/QtQuick/XmlListModel -lqmlxmllistmodelplugin$$qtPlatformTargetSuffix()

# work-around Q_CONSTRUCTOR_FUNCTION:
LIBS += -Wl,-force_load,$$[QT_INSTALL_LIBS]/libQt5Quick$$qtPlatformTargetSuffix().a

