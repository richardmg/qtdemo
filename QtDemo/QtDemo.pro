TEMPLATE = app
contains(CONFIG, release): CONFIG += release

QMAKE_INFO_PLIST = Info.plist
icons.files += Icon.png
QMAKE_BUNDLE_DATA += icons

QT += qml quick multimedia xmlpatterns
HEADERS += shaderfilereader.h
SOURCES += main.cpp shaderfilereader.cpp
RESOURCES += resources.qrc

qml2.files = qml2
QMAKE_BUNDLE_DATA += qml2

qmldir.files += $$(QTDIR)/qml
QMAKE_BUNDLE_DATA += qmldir

QTDIR = /Volumes/Code/qt-src/qt-50-ios-dev/qtbase
LIBS += -L$$(QTDIR)/qml/QtQuick.2 -lqtquick2plugin
LIBS += -L$$(QTDIR)/qml/QtQuick/Window.2 -lwindowplugin
LIBS += -L$$(QTDIR)/qml/QtQuick/Particles.2 -lparticlesplugin
LIBS += -L$$(QTDIR)/qml/QtQuick/XmlListModel -lqmlxmllistmodelplugin

# work-around Q_CONSTRUCTOR_FUNCTION:
LIBS += -Wl,-force_load,$$(QTDIR)/lib/libQt5Quick.a

