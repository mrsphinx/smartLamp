local module={}

module.SSID="nodemcu"
module.PASSWORD="12345678"
module.LEDpin = 2                  -- declare LED pin

module.HOST = "broker.example.com"
module.PORT = 1884
module.ID = node.chipid()

module.ENDPOINT = "nodemcu/"
return module