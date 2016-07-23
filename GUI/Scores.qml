import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    height: 860
    width: 484
    visible: true
    color: "#303030"
    AndroidToolbar{
        id: toolbar_game
        BackButton{
            id: backbutton
            onClicked:{
                stack.pop(stack.pop())
            }
        }
        Text{
            color: "#FFFFFF"
            text: qsTr("Minesweeper - Qt quick")
            width: parent.width
            anchors.left: backbutton.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.45
            wrapMode: Text.Wrap
        }
    }
    Row
    {
        anchors.bottom: parent.bottom
        id:myrow
        width:parent.width
        Button
        {
            id:myButton
            text:"add"
            //onClicked: mediator.insertScore(babis.text, babis.text, 0);
        }
        Button
        {
            id:myButton2
            text:"delete"
            onClicked: mediator.deleteScore (myView.currentIndex, 0);
        }
        TextField
        {
            id:babis
        }
    }
    ListView
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: parent.height/2
        id:myView
        anchors.margins: 5
        highlight: Rectangle{
            width: parent.width
            color: "#303030"
        }
        model:mediator.myModel1
        delegate: Item{
            width:parent.width
            height:50
            Label{
                text:name
                font.pixelSize: parent.height*0.5
                color: "#FF5722"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked: myView.currentIndex=index
            }
        }
    }
}
