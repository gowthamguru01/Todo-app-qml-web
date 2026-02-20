import QtQuick 2.0 

Rectangle {
    id: root
    width: 1200
    height: 800
    color: "#0b1120"

    property var todoArray: []
  
   //Phone like container middle 
   
   Rectangle {
        id: phone 
        width: 420
        height: 720 
        radius:30 
        anchors.centerIn: parent 


        // gradient background inside phone 
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1e293b" }
            GradientStop { position: 1.0; color: "#0f172a" }
        }
        

        Column {
            width: parent.width
            spacing: 14
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter

            

            Text {
                text: "Todo List"
                color: "white"
                font.pixelSize: 28
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // Todo input container 
            Rectangle {
                id: inputContainer
                width: parent.width - 40
                height: 60
                radius: 14 
                color: "#334155"
                anchors.horizontalCenter: parent.horizontalCenter

                //text input for todo 
                 TextInput {
                    id: input
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width - addBtn.width - 40
                    height: 30
                    focus: true
                }

                //ADD button 
                Rectangle {
                    id: addBtn
                    width: 70
                    height: 30
                    radius: 8
                    color: addHover.containsMouse ? "#3b82f6" : "#2563eb"

                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        text: "Add"
                        color: "white"
                        anchors.centerIn: parent
                    }
                     MouseArea {
                        id: addHover
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {

                            if (root.todoArray.length >= 8){
                                console.log("Maximum limit reached")
                                return
                            }
                            
                            var newTask = input.text 
                            var tempArray = root.todoArray.slice()
                             tempArray.push({
                                task: newTask,
                                done: false
                             })
                                root.todoArray = tempArray
                                input.text = ""
                        }
                    }
                    
                }
            }
            // we have used repeater to show the list of todo items       
                width: parent.width
                height: 100              
                Column {
                    width: parent.width
                    spacing: 10
                    anchors.top: inputContainer.bottom
                    anchors.topMargin: 20
                        Repeater {
                            model: root.todoArray
                            delegate: Rectangle {
                                width: parent.width - 40
                                height: 60
                                radius: 12
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: "#334155"

                                Text {
                                    text: modelData.task
                                    color: "white"
                                    anchors.centerIn: parent
                                }

                                Rectangle {
                                    id: checkBox
                                    width: 20
                                    height: 20
                                    radius: 4
                                    color: modelData.done
                                            ? "#22c55e"
                                              : (checkHover.containsMouse ? "#94a3b8" : "#64748b")

                                    anchors.left: parent.left
                                    anchors.leftMargin: 16
                                    anchors.verticalCenter: parent.verticalCenter

                                    MouseArea {
                                        id: checkHover
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            var temp = root.todoArray.slice() 
                                            temp[index].done = !temp[index].done
                                            root.todoArray = temp
                                    }
                                    }
                                }

                                Image {
                                    id: deleteBtn
                                    source: "/dist/assets/delete.png"
                                    width: 22
                                    height: 22
                                    anchors.right: parent.right
                                    anchors.rightMargin: 16
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: deleteHover.containsMouse ? 1 : 0.5
                                }

                                MouseArea {
                                    id: deleteHover
                                    anchors.fill: deleteBtn
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        var temp = root.todoArray.slice()
                                        temp.splice(index, 1)
                                        root.todoArray = temp
                                    }
                                }


                            }
                                
                        }
                }
                
            }
        }
}