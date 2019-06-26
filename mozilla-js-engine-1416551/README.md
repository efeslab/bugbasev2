# Mozilla Bug 1416551
- Behaviour: Segmentation fault
- Crash version: SpiderMonkey45 https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Releases/45
- Cause: Assertion Failure
- Failure Sketch:
    + !done(), at ```/tmp/mozjs-45.0.2/js/src/vm/ScopeObject.cpp:1483```, code ```MOZ_ASSERT(!done());```
- Fixed Version: SpiderMonkey52