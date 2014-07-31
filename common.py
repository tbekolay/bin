import collections
import os

def activate_venv(env):
    """Activate a virtual environment.

    Used by basically all of my nontrivial Python scripts.
    """

    if not os.environ.get('VIRTUAL_ENV', '').endswith(env):
        home = os.path.expanduser('~')
        venv_home = os.environ.get('WORKON_HOME',
                                   os.path.join(home, '.virtualenvs'))
        venv = os.path.join(venv_home, env)
        if os.path.exists(venv):
            activate_this = os.path.join(venv, 'bin', 'activate_this.py')
            execfile(activate_this, dict(__file__=activate_this))


# Used in start_day, end_day
answer = collections.namedtuple('answer', ['title', 'text', 'callback'])

def say(t, intro, answers=(), prompt=None, ch_included=None):
    """Say something to terminal.

    Optionally, list a series of possible responses with ``answers``.

    Optionally, prompt for a response with ``prompt``.

    Optionally, only require the input of ``ch_included`` characters.

    Used in start_day and end_day.
    """
    print(intro)
    for ans in answers:
        if ans.text is None:
            continue
        with t.location(x=2):
            print("%s\t%s" % (t.underline(ans.title), ans.text))
    if prompt is not None:
        if ch_included is None:
            chars = [a.title for a in answers]
        else:
            chars = [a.title[:min(ch_included, len(a.title))] for a in answers]
        while ans not in chars:
            ans = raw_input("{prompt} [{chars}]: ".format(
                prompt=prompt, chars='/'.join(chars)))
        ans = answers[chars.index(ans)]
        if ans.callback is not None:
            return ans.callback()
        return ans
