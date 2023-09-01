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
                <arg type='d' name='message' direction='out'/>
            </method>
            <method name='getCurrent'>
                <arg type='d' name='message' direction='out'/>
            </method>
        </interface>
    </node>
    """

    def __init__(self) -> None:
        self.piracer = PiRacerStandard()
        self.shanwan_gamepad = ShanWanGamepad()
        self.battery_voltage = 0
        self.battery_current = 0
        self.monitor_thread = threading.Thread(target=self.update_values)
        self.monitor_thread.daemon = True  # Ensure thread is killed on program exit
        self.monitor_thread.start()
        self.control_thread = threading.Thread(target=self.control_piracer)
        self.control_thread.daemon = True
        self.control_thread.start()
        
    
    def update_values(self) -> None:
        while True:
            self.battery_voltage = self.piracer.get_battery_voltage()
            self.battery_current = self.piracer.get_battery_current()
            time.sleep(30)

    def control_piracer(self) -> None:
        while True:
            gamepad_input = self.shanwan_gamepad.read_data()
            throttle = gamepad_input.analog_stick_right.y * -0.5
            steering = -gamepad_input.analog_stick_left.x
            self.piracer.set_throttle_percent(throttle)
            self.piracer.set_steering_percent(steering)
            time.sleep(0.03)

    def getVoltage(self) -> float:
        return self.battery_voltage

    def getCurrent(self) -> float:
        return self.battery_current

bus = SessionBus()
bus.publish("com.example.piracerService", piracerService())

loop = GLib.MainLoop()
loop.run()
