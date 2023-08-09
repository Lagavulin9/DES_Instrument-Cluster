import time
import threading
from pydbus import SessionBus
from gi.repository import GLib
from piracer.vehicles import PiRacerStandard
from piracer.gamepads import ShanWanGamepad

class piracerService():
    dbus = """
    <node>
        <interface name='com.example.piracerService'>
            <method name='getVoltage'>
                <arg type='i' name='message' direction='out'/>
            </method>
            <method name='getCurrent'>
                <arg type='i' name='message' direction='out'/>
            </method>
        </interface>
    </node>
    """

    def __init__(self) -> None:
        self.piracer = PiRacerStandard()
        self.shanwan_gamepad = ShanWanGamepad()
        self.battery_voltage = 0
        self.battery_current = 0
        self.update_thread = threading.Thread(target=self.update_values)
        self.update_thread.daemon = True  # Ensure thread is killed on program exit
        self.update_thread.start()

    def update_thread(self) -> None:
        self.battery_voltage = self.piracer.get_battery_voltage()
        self.battery_current = self.piracer.get_battery_current()
        time.sleep(30)

    def getVoltage(self) -> int:
        return self.battery_voltage

    def getCurrent(self) -> int:
        return self.battery_current

bus = SessionBus()
bus.publish("com.example.piracerService", piracerService())

loop = GLib.MainLoop()
loop.run()