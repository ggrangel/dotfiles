def match(command):
    return "z" in command.output.lower()
    # return True


def get_new_command(command):
    return f"v{command.script[1:]}"


priority = 1

requires_output = False
