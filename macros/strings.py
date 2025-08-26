def define_env(env):
    @env.macro
    def shout(text):
        """Macht Text groß und mit Ausrufezeichen."""
        return text.upper() + "!"
