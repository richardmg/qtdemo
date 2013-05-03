import QtQuick 2.0
import "engine.js" as Engine
import "style.js" as Style

Rectangle{
    id: app
    clip: true
    color: "white"
    property real homeScaleFactor: .2
    property int homeCenterX: 0
    property int homeCenterY: 0
    property real minScaleFactor: .04
    property real maxScaleFactor: 1
    property real tapLimitX : 2
    property real tapLimitY : 1

    function calculateScales(){
        if (app.width > 0 && app.height > 0){
            var appWidth = app.width*0.9;
            var appHeight = app.height*0.9;

            var bbox = Engine.boundingBox();
            app.homeScaleFactor = Engine.scaleToBox(appWidth, appHeight, bbox.width, bbox.height);
            app.homeCenterX = bbox.centerX;
            app.homeCenterY = bbox.centerY;
            app.minScaleFactor = app.homeScaleFactor / 10;
            app.maxScaleFactor = app.homeScaleFactor * 20;
            Engine.updateObjectScales(app.width*0.8, app.width*0.8); //app.width, app.height);
            tapLimitX = Math.max(1,app.width * 0.02);
            tapLimitY = Math.max(1,app.height * 0.02);

            canvas.goHome()
        }
    }
    function selectTarget(uid) {
        return Engine.selectTarget(uid)
    }

    function getNext() {
        return Engine.getNext()
    }

    function getPrevious() {
        return Engine.getPrevious()
    }

    onWidthChanged: calculateScales();
    onHeightChanged: calculateScales();

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#89d4ff" }
        GradientStop { position: 1.0; color: "#f3fbff" }
    }

    Cloud { id: cloud1; sourceImage: "images/cloud1.svg"}
    Cloud { id: cloud2; sourceImage: "images/cloud1.svg"}
    Cloud { id: cloud3; sourceImage: "images/cloud2.svg"}
    Cloud { id: cloud4; sourceImage: "images/cloud2.svg"}

    Item{
        id: pinchProxy
        scale:.2
        onRotationChanged: canvas.angle=rotation
        onScaleChanged: canvas.scalingFactor=scale
    }

    WorldMouseArea { id: worldMouseArea }
    WorldPinchArea { id: worldPinchArea }
    WorldCanvas { id:canvas }
    NavigationPanel{
        id: navigationPanel
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: app.width * 0.02
        spacing: app.height * 0.05
    }


    NumberAnimation {
        id: zoomAnimation
        target: canvas;
        property: "scalingFactor";
        duration: Style.APP_ANIMATION_DELAY;
        to:canvas.zoomInTarget

        onRunningChanged: {
            if (!running) {
                if (canvas.zoomInTarget !== app.homeScaleFactor)
                    Engine.loadCurrentDemo();
                else
                    Engine.releaseDemos();
            }
        }
    }

    SequentialAnimation {
        id: navigationAnimation

        NumberAnimation {
            id: zoomOutAnimation
            target: canvas;
            property: "scalingFactor";
            duration: Style.APP_ANIMATION_DELAY/2;
            to: app.homeScaleFactor
            easing.type: Easing.OutCubic
        }

        NumberAnimation {
            id: zoomInAnimation
            target: canvas;
            property: "scalingFactor";
            duration: Style.APP_ANIMATION_DELAY/2;
            to: canvas.zoomInTarget
            easing.type: Easing.InCubic
        }

        onRunningChanged: {
            if (!running) {
                if (canvas.zoomInTarget !== app.homeScaleFactor)
                    Engine.loadCurrentDemo();
                else
                    Engine.releaseDemos();
            }
        }
    }

    Component.onCompleted: {
        print("START TO INITIALIZE SLIDES")
        Engine.initSlides()
        print("SLIDES READY")
        cloud1.start();
        cloud2.start();
        cloud3.start();
        cloud4.start();
    }
}
