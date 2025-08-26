import QtQuick
import Quickshell

Scope {
	id: root
	required property real side

	PanelWindow {

		implicitWidth: root.side
		implicitHeight: root.side

		anchors: {
			top: true
			right: true
		}

		Text {
			text: "BATTERY"
		}
	}
}
