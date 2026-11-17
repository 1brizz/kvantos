import QtQuick 2.0

Rectangle {
    id: root
    color: "#10141a"

    Column {
        anchors.centerIn: parent
        spacing: 16

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#c8ebf5"
            font.pixelSize: 30
            font.bold: true
            text: "Установка KvantOS"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#9aa7b4"
            font.pixelSize: 16
            text: "Дистрибутив для обучения программированию"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#5d6a76"
            font.pixelSize: 13
            text: "Кофе можно не отходить — установка уже идёт."
        }
    }
}
