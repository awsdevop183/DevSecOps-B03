import psutil

# threshold = int(input("Enter your threshold: "))

# print(type(threshold))

def get_system_info():
    """
    this function gives information about your system
    """
    cpu = psutil.cpu_percent(interval=1)
    memory = psutil.virtual_memory().percent
    disk = psutil.disk_usage("/").percent


    sys_info = {
        "cpu_usage": cpu,
        "memory_usage": memory,
        "disk_usage": disk
    }

    # print(sys_info)
    return sys_info

# get_system_info()











# if cpu > threshold:
#     print("CPU is high")
# elif cpu <= 30:
#     print("CPU is normal")
# else:
#     print("CPU is under utilized")


# python3 -m venv venv
# apt install python3.14-venv -y

# pip list
# apt install python3-pip
