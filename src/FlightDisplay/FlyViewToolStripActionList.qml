/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQml.Models

import QGroundControl
import QGroundControl.Controls

ToolStripActionList {
    id: _root

    signal displayPreFlightChecklist
    property var    _activeVehicle:             QGroundControl.multiVehicleManager.activeVehicle

    model: [
        ToolStripAction {
            text:           qsTr("Plan")
            iconSource:     "/qmlimages/Plan.svg"
            onTriggered:{
                mainWindow.showPlanView()
                viewer3DWindow.close()
            }
        },
        ToolStripAction {
            text:           qsTr("Cut engine")
            iconSource:     "/res/engineCut.svg"
            // enabled:        QGroundControl.activeVehicle && QGroundControl.activeVehicle.linkManager.activeLinkConnected
            enabled: true
            onTriggered:{
                console.log("Button clicked");
                _activeVehicle.triggerEngineOff()
                   // if (QGroundControl) {
                   //     console.log("QGroundControl object is available");
                   // } else {
                   //     console.log("QGroundControl object is NOT available");
                   // }

                   // if (QGroundControl.activeVehicle) {
                   //     console.log("Active vehicle is available");
                   // } else {
                   //     console.log("Active vehicle is NOT available");
                   // }

                   // if (QGroundControl.activeVehicle && QGroundControl.activeVehicle.linkManager.activeLinkConnected) {
                   //     console.log("Vehicle is connected");
                   //     QGroundControl.activeVehicle.triggerEngineOff();
                   // } else {
                   //     console.log("No active vehicle or vehicle not connected.");
                   // }
            }
        },
        ToolStripAction {
            text:           qsTr("Parachute")
            iconSource:     "/res/parachute.svg"
            enabled:    false
            onTriggered:{
                mainWindow.showPlanView()
                viewer3DWindow.close()
            }
        },
        ToolStripAction {
            property bool _is3DViewOpen:            viewer3DWindow.isOpen
            property bool   _viewer3DEnabled:       QGroundControl.settingsManager.viewer3DSettings.enabled.rawValue

            id: view3DIcon
            visible: _viewer3DEnabled
            text:           qsTr("3D View")
            iconSource:     "/qmlimages/Viewer3D/City3DMapIcon.svg"
            onTriggered:{
                if(_is3DViewOpen === false){
                    viewer3DWindow.open()
                }else{
                    viewer3DWindow.close()
                }
            }

            on_Is3DViewOpenChanged: {
                if(_is3DViewOpen === true){
                    view3DIcon.iconSource =     "/qmlimages/PaperPlane.svg"
                    text=           qsTr("Fly")
                }else{
                    iconSource =     "/qmlimages/Viewer3D/City3DMapIcon.svg"
                    text =           qsTr("3D View")
                }
            }
        },
        PreFlightCheckListShowAction { onTriggered: displayPreFlightChecklist() },
        GuidedActionTakeoff { },
        GuidedActionLand { },
        GuidedActionRTL { },
        GuidedActionPause { },
        GuidedActionActionList { },
        GuidedActionGripper { }
    ]
}
