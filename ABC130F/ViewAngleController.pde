// This tab is independent.
// Last update: 2. Oct. 2017

final class ViewAngleController
{
  final float unitAngleVelocity;

  float fieldOfViewAngle;
  final float initialFieldOfViewAngle;
  final float aspectRatio;
  final float cameraXPosition, cameraYPosition;
  float cameraZPosition;
  float nearestClippingPlaneZPosition, farthestClippingPlaneZPosition;

  final float centerXPosition, centerYPosition, centerZPosition;

  float xRotationAngle, yRotationAngle, zRotationAngle;
  final float initialXRotationAngle, initialZRotationAngle;

  final ArrayList<UncodedKeyChecker> keyCheckerList = new ArrayList<UncodedKeyChecker>();
  final ArrayList<KeyCodeChecker> keyCodeCheckerList = new ArrayList<KeyCodeChecker>();
  final ArrayList<MouseDragChecker> mouseDragCheckerList = new ArrayList<MouseDragChecker>();
  boolean checksUncodedKey, checksCodedKey, checksMouseDrag;

  ViewAngleController(float initXRot, float initZRot, float initFov, float angleVelocityPerSecond, float idealFrameRate, float centerYPositionOffset) {
    // constants
    unitAngleVelocity = angleVelocityPerSecond / idealFrameRate;

    // perspective
    aspectRatio = float(width) / float(height);
    cameraXPosition = width * 0.5;
    cameraYPosition = height * 0.5;

    // translation
    centerXPosition = width * 0.5;
    centerYPosition = height * 0.5 + centerYPositionOffset;
    centerZPosition = 0.0;

    // rotation
    initialXRotationAngle = initXRot;
    initialZRotationAngle = initZRot;
    initialFieldOfViewAngle = initFov;

    initialize();
  }
  ViewAngleController() {
    this(QUARTER_PI, 0.0, PI / 3.0, QUARTER_PI, 60.0, 0.0);
  }

  void initialize() {
    setFieldOfViewAngle(initialFieldOfViewAngle);

    xRotationAngle = initialXRotationAngle;
    yRotationAngle = 0.0;
    zRotationAngle = initialZRotationAngle;
  }

  void addKeyChecker(UncodedKeyChecker checker) {
    keyCheckerList.add(checker);
    checksUncodedKey = true;
  }
  void addKeyCodeChecker(KeyCodeChecker checker) {
    keyCodeCheckerList.add(checker);
    checksCodedKey = true;
  }
  void addMouseDragChecker(MouseDragChecker checker) {
    mouseDragCheckerList.add(checker);
    checksMouseDrag = true;
  }  

  void addFieldOfViewAngle(float v) {
    setFieldOfViewAngle(fieldOfViewAngle + v * unitAngleVelocity);
  }
  void setFieldOfViewAngle(float v) {
    fieldOfViewAngle = v;
    cameraZPosition = cameraYPosition / tan(fieldOfViewAngle * 0.5);
    nearestClippingPlaneZPosition = cameraZPosition * 0.05;
    farthestClippingPlaneZPosition = cameraZPosition * 10.0;
  }

  void addXRotationAngle(float v) {
    xRotationAngle += v * unitAngleVelocity;
  }
  void addYRotationAngle(float v) {
    yRotationAngle += v * unitAngleVelocity;
  }
  void addZRotationAngle(float v) {
    zRotationAngle += v * unitAngleVelocity;
  }

  void applyPerspective() {
    perspective(fieldOfViewAngle, aspectRatio, nearestClippingPlaneZPosition, farthestClippingPlaneZPosition);
  }
  void translateCoordinates() {
    translate(centerXPosition, centerYPosition, centerZPosition);
  }
  void rotateCoordinates() {
    rotateX(xRotationAngle);
    rotateY(yRotationAngle);
    rotateZ(zRotationAngle);
  }

  void checkKey() {
    if (!keyPressed) return;
    processKey();
  }
  void processKey() {
    if (checksCodedKey && key == CODED) {
      for (KeyCodeChecker eachChecker : keyCodeCheckerList) {
        eachChecker.checkKeyCode(keyCode, this);
      }
    }
    
    if (checksUncodedKey) {
      for (UncodedKeyChecker eachChecker : keyCheckerList) {
        eachChecker.checkKey(key, this);
      }
    }
  }
  
  void processMouseDragged() {
    if (checksMouseDrag == false) return;
    
      for (MouseDragChecker eachChecker : mouseDragCheckerList) {
        eachChecker.check(this);
      }
  }
}



abstract class InputChecker
{
  final ViewAngleKeyEventHandler handler;
  final float sensitivity;

  InputChecker(ViewAngleKeyEventHandler _handler, float _sensitivity) {
    handler = _handler;
    sensitivity = _sensitivity;
  }

  void execute(ViewAngleController controller) {
    execute(controller, 1.0);
  }
  void execute(ViewAngleController controller, float angleVelocityFactor) {
    handler.execute(controller, angleVelocityFactor);
  }
}

final class UncodedKeyChecker
  extends InputChecker
{
  final char triggerKey;

  UncodedKeyChecker(char _triggerKey, ViewAngleKeyEventHandler _handler, float _sensitivity) {
    super(_handler, _sensitivity);
    triggerKey = _triggerKey;
  }

  void checkKey(char currentKey, ViewAngleController controller) {
    if (currentKey == triggerKey) execute(controller, sensitivity);
  }
}

final class KeyCodeChecker
  extends InputChecker
{
  final int triggerKeyCode;

  KeyCodeChecker(int _triggerKeyCode, ViewAngleKeyEventHandler _handler, float _sensitivity) {
    super(_handler, _sensitivity);
    triggerKeyCode = _triggerKeyCode;
  }

  void checkKeyCode(int currentKeyCode, ViewAngleController controller) {
    if (currentKeyCode == triggerKeyCode) execute(controller, sensitivity);
  }
}

abstract class MouseDragChecker
  extends InputChecker
{
  MouseDragChecker(ViewAngleKeyEventHandler _handler, float _sensitivity) {
    super(_handler, _sensitivity);
  }

  abstract void check(ViewAngleController controller);
}

final class VerticalMouseDragChecker
  extends MouseDragChecker
{
  VerticalMouseDragChecker(ViewAngleKeyEventHandler _handler, float _sensitivity) {
    super(_handler, _sensitivity);
  }

  void check(ViewAngleController controller) {
    execute(controller, (mouseY - pmouseY) * sensitivity);
  }
}
final class HorizontalMouseDragChecker
  extends MouseDragChecker
{
  HorizontalMouseDragChecker(ViewAngleKeyEventHandler _handler, float _sensitivity) {
    super(_handler, _sensitivity);
  }

  void check(ViewAngleController controller) {
    execute(controller, (mouseX - pmouseX) * sensitivity);
  }
}



abstract class ViewAngleKeyEventHandler
{
  abstract void execute(ViewAngleController controller, float angleVelocityFactor);

  void execute(ViewAngleController controller) {
    execute(controller, 1.0);
  }
}

class AddXRotation
  extends ViewAngleKeyEventHandler
{
  void execute(ViewAngleController controller, float angleVelocityFactor) {
    controller.addXRotationAngle(angleVelocityFactor);
  }
}

class AddYRotation
  extends ViewAngleKeyEventHandler
{
  void execute(ViewAngleController controller, float angleVelocityFactor) {
    controller.addYRotationAngle(angleVelocityFactor);
  }
}

class AddZRotation
  extends ViewAngleKeyEventHandler
{
  void execute(ViewAngleController controller, float angleVelocityFactor) {
    controller.addZRotationAngle(angleVelocityFactor);
  }
}

class AddFieldOfViewAngle
  extends ViewAngleKeyEventHandler
{
  void execute(ViewAngleController controller, float angleVelocityFactor) {
    controller.addFieldOfViewAngle(angleVelocityFactor);
  }
}
