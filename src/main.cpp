// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlExtensionPlugin>
#include <QDebug>
#include <QtPlugin>
//Activate if you want to do QML profiling
//#include <QQmlDebuggingEnabler>

#if defined(CLAY_STATIC_PLUGIN)
    Q_IMPORT_PLUGIN(ClayPhysicsPlugin);
    Q_IMPORT_PLUGIN(ClayCanvasPlugin);
    Q_IMPORT_PLUGIN(ClayCommonPlugin);
    Q_IMPORT_PLUGIN(SvgPlugin);
    Q_IMPORT_PLUGIN(ClayWorldPlugin);
    Q_IMPORT_PLUGIN(ClayGameCtrlPlugin);
    Q_IMPORT_PLUGIN(ClayStoragePlugin);
    Q_IMPORT_PLUGIN(Box2DPlugin);

    #define REGISTER_TYPES(class_name, plugin_name) \
        qobject_cast<QQmlExtensionPlugin*>(qt_static_plugin_##class_name().instance()) \
            ->registerTypes(plugin_name);
#endif

int main(int argc, char *argv[])
{
#if defined(CLAY_STATIC_PLUGIN)
    REGISTER_TYPES(ClayCommonPlugin, "Clayground.Common");
    REGISTER_TYPES(SvgPlugin, "Clayground.Svg");
    REGISTER_TYPES(ClayWorldPlugin, "Clayground.World");
    REGISTER_TYPES(ClayGameCtrlPlugin, "Clayground.GameController");
    REGISTER_TYPES(ClayCanvasPlugin, "Clayground.Canvas");
    REGISTER_TYPES(ClayPhysicsPlugin, "Clayground.Physics");
    REGISTER_TYPES(ClayStoragePlugin, "Clayground.Storage");
    REGISTER_TYPES(Box2DPlugin, "Box2D");
#endif

    //Activate if you want to do QML profiling
    //QQmlDebuggingEnabler enabler;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

#if defined(CLAY_STATIC_PLUGIN)
    qobject_cast<QQmlExtensionPlugin*>(qt_static_plugin_SvgPlugin().instance()) \
        ->initializeEngine(&engine, "Clayground.Svg");
#endif

    auto runAsAutoTest = QGuiApplication::platformName() == "minimal";
    if (runAsAutoTest) {
        QObject::connect(&engine,
                         &QQmlApplicationEngine::warnings,
                         [=] (const QList<QQmlError>& warnings) {
            for (auto& w: warnings) qCritical() << w.toString();
            exit(1);
        }
        );
    }

    // Android demands qml plugins to be stored under qml, use same approach
    // for all other platforms too
    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.load(QUrl("qrc:/qml/main.qml"));
    return app.exec();
}

