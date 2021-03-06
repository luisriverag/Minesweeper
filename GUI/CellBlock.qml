import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "qrc:/Styles/" 1.0

Button{
    id: cellBlock
    //cell size is set so 9 cells fit on the screen's width by default and 14 cells fit on the screen's width on widescreen setups
    property double cellSize: root.height > root.width ? (gameFlickable.width-8*game.height*0.001)/9 : (gameFlickable.width-13*game.height*0.001)/14
    height: cellSize
    width: cellSize
    property string cellText
    property string cellTextColor: Style.color.cellTextColor
    property string cellColor: Style.color.cellColorNotPressed
    property int x_position
    property int y_position
    property int m: 0
    property int n: 0

    Text{
        id: cellTextArea
        anchors.fill: parent
        text: cellText
        color: cellTextColor
        font.pixelSize: parent.height*0.7
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "whatever"
    }
    style: ButtonStyle {
       background:
            Rectangle {
               color: innerMouseArea.pressed ? game.cellColorPressed : cellColor;
                radius: 1;
            }
    }

    MouseArea {
        id: innerMouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        Image {
            id: backgroundImage
            anchors.fill: parent
            smooth: true
        }
        onPressAndHold: {
            if(mouse.button & Qt.LeftButton){
                if(game.flagClick){
                    game.leftClicked(x_position, y_position)
                } else {
                    game.rightClicked(x_position, y_position)
                }
            }
        }
        //if statements for checking for flag mode/reveal mode
        onClicked:
        {
            if(mouse.button & Qt.LeftButton){
                if(game.flagClick){
                    game.rightClicked(x_position, y_position)
                } else {
                    game.leftClicked(x_position, y_position)
                }
            }else if(mouse.button & Qt.RightButton) {
                if(game.flagClick){
                    game.leftClicked(x_position, y_position)
                } else {
                    game.rightClicked(x_position, y_position)
                }
            }
        }

        onDoubleClicked: {
            if(mouse.button & Qt.LeftButton){
               game.doubleClicked(x_position, y_position)
            }
        }
    }

    //functions for setting the cell image
    function setBombImage() {
        backgroundImage.source = Style.icons.red_mine;
    }

    function setFlagImage() {
        backgroundImage.source = Style.icons.flag;
    }

    function clearImage(){
        backgroundImage.source = Style.icons.clear;
    }

    function setFlaggedBombImage() {
        backgroundImage.source = Style.icons.flagged_mine;
    }

    //resets this particular cell
    function reset() {
        cellText = "";
        enabled = true;
        backgroundImage.source = Style.icons.clear;
        cellColor = game.cellColorNotPressed;
        cellTextColor = Style.color.cellTextColor
    }
}
