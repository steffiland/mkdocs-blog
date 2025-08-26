from datetime import date, timedelta

def define_env(env):
    @env.macro
    def today(delta=0):
        """Gibt das heutige Datum zurück, optional mit Offset."""
        return (date.today() + timedelta(days=delta)).isoformat()
