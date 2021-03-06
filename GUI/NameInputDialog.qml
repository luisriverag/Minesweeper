import QtQuick 2.5
import QtQuick.Controls 1.4
import "qrc:/Styles/" 1.0

//A rectangle for entering a players name, for the highscore section
Item{
    id: nameInputDialog
    height: root.height
    width: root.width
    Rectangle{
        id: opacityBox
        anchors.fill: parent
        color: "black"
        opacity: 0
        OpacityAnimator {
            id: opacityAnimation
            target: opacityBox
            from: 0
            to: 0.7
            duration: 200
            running: false
            easing.type: Easing.OutQuad
        }
        onVisibleChanged: {
            if(visible === true){
                opacityAnimation.running = true
            } else {
                opacity = 0;
                opacityAnimation.running = false
            }
        }
    }
    Rectangle{
        property int minDim: Math.min(parent.height, parent.width);
        width: minDim*0.9
        height: minDim*0.5
        visible: true
        color: Style.color.dialog_Background
        anchors.centerIn: parent
        Keys.enabled: true
        Keys.onReleased: {
            if(event.key === Qt.Key_Back){
                event.accepted = true;
                nameInputDialog.visible = false;
                nameInputField.text = "";
            }
        }
        Text{
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: parent.height*0.05
            color: Style.color.dialog_Text
            text: qsTr("Please enter your name")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.height*0.14
        }

        Rectangle{
            id: nameRect
            visible:true
            color: Style.color.dialog_Background
            height: parent.height*0.2
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.3
            width: parent.width*0.9
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                id: nameText
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                color: Style.color.dialog_Text
                width: parent.width*0.3
                text: qsTr("Name: ")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: parent.height*0.6
            }
            DarkTextField{
                id: nameInputField
                anchors.top: parent.top
                anchors.left: nameText.right
                anchors.right: parent.right
                anchors.rightMargin: parent.width*0.1
                anchors.bottom: parent.bottom
                font.pixelSize: parent.height*0.5
                horizontalAlignment: Text.AlignHCenter
                validator: RegExpValidator{regExp: /\S{0,15}/}
                onAccepted: {
                    acceptName()
                }
            }
        }
        Rectangle{
            color: Style.color.dialog_Background
            anchors.top: nameRect.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: parent.height*0.15
            anchors.bottomMargin: parent.height*0.1
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.7
            AndroidButton{
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: parent.width*0.4
                Text{
                    color: Style.color.android_Button_Text
                    width: parent.width
                    height: parent.height
                    text: qsTr("Accept")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    font.pixelSize: parent.height*0.5
                }
                onClicked: {
                    soundMngr.playSound()
                    nameInputDialog.acceptName();
                }
            }
            AndroidButton{
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                width: parent.width*0.4
                Text{
                    color: Style.color.android_Button_Text
                    width: parent.width
                    height: parent.height
                    text: qsTr("Cancel")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    font.pixelSize: parent.height*0.5
                }
                onClicked: {
                    soundMngr.playSound()
                    nameInputDialog.visible = false;
                    nameInputField.text = ""
                }
            }
        }
    }
    function acceptName(){
        if(nameInputField.length === 0){
            toast.show("Please enter a name");
        } else {
            if (choice.difficulty == 1) {
                mediator.insertScore(nameInputField.text, secondCounter.seconds, 0);
            } else if (choice.difficulty == 2) {
                mediator.insertScore(nameInputField.text, secondCounter.seconds, 1);
            } else if (choice.difficulty == 3) {
                mediator.insertScore(nameInputField.text, secondCounter.seconds, 2);
            }
            nameInputDialog.visible = false;
            nameInputField.text = ""
        }
    }
}
