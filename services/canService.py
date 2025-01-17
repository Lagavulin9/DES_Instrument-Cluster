import os
import time
import can
import threading
from pydbus import SessionBus
from gi.repository import GLib

CAN_CHANNEL = "can0"
BITRATE = 500000 #500Kbps
DBITRATE = 8000000 #8Mbps
MAX_TRY = 10

class canService:
    dbus = """
    <node>
        <interface name='com.example.canService'>
            <method name='getDis'>
                <arg type='i' name='message' direction='out'/>
            </method>
            <method name='getRPM'>
                <arg type='i' name='message' direction='out'/>
            </method>
        </interface>
    </node>
    """

    def __init__(self):
        self.init_CAN()
        self.can = can.interface.Bus(channel=CAN_CHANNEL, bustype='socketcan')
        self.rpm = 0
        self.distance = 0
        self.update_thread = threading.Thread(target=self.update_values)
        self.update_thread.daemon = True  # Ensure thread is killed on program exit
        self.update_thread.start()

    def init_CAN(self) -> bool:
        tries = 0
        while True:
            try:
                os.system(f'sudo ifconfig {CAN_CHANNEL} down')
                os.system(f'sudo ip link set {CAN_CHANNEL} up type can bitrate {BITRATE} dbitrate {DBITRATE} restart-ms 1000 berr-reporting on fd on')
                return True
            except:
                print(f"CAN setup failed. ({tries}/{MAX_TRY})")
                if (tries == MAX_TRY):
                    print("Shutting Down")
                    exit(1)
                time.sleep(1)

    def update_values(self):
        while True:
            msg = self.can.recv(timeout=0.1)
            if msg is not None:
                self.rpm = msg.data[0] + msg.data[1] * 256
                self.distance = msg.data[2] + msg.data[3] * 256

    def getDis(self) -> int:
        return self.distance

    def getRPM(self) -> int:
        return self.rpm



bus = SessionBus()
bus.publish("com.example.canService", canService())

loop = GLib.MainLoop()
loop.run()
