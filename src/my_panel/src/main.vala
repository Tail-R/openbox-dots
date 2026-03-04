using CustomWidgets;

public class MyApp : Gtk.Application {
    private const string APP_ID = "local.ronove.MyPanel";
    private const string CSS_PATH = "assets/style.css";

    public MyApp() {
        Object(application_id: APP_ID);
    }

    public override void activate() {
        load_css();

        var window = new MyWindow(this);
        window.present();
    }

    public static int main(string[] args) {
        var app = new MyApp();

        return app.run(args);
    }

    // CSS loader
    private void load_css() {
        var provider = new Gtk.CssProvider();
        provider.load_from_path(CSS_PATH);
        
        Gtk.StyleContext.add_provider_for_display(
            Gdk.Display.get_default(),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );
    }
}

/* 
    Main window
 */
public class MyWindow : Gtk.ApplicationWindow {
    private const string WIN_TITLE   = "My Panel :3";
    private const int    WIN_WIDTH   = 1;
    private const int    WIN_HEIGHT  = 1;
    private const bool   WIN_RESIZABLE = false;

    public MyWindow(Gtk.Application app) {
        Object(
            application: app,
            title: WIN_TITLE,
            default_width: WIN_WIDTH,
            default_height: WIN_HEIGHT,
            resizable: WIN_RESIZABLE
        );

        this.child = new Panel();
    }
}

public class Panel : MyBox {
    public Panel() {
        base(V, "root-box");

        /*
            Header 
         */
        var header = new MyLabel("", "header")
            .poll_command_sync(1000, "date '+%Y年 %m月%d日 %A %H時%M分'")
            .expand_v(false);

        /*
            Top section 
         */
        var top_box = new MyBox(H, "top-box").pack(

            new MyBox(V, "user-info").pack(
                new Cerberus(
                    H, "user-name",
                    new MyLabel("• Username", "name"),
                    new MyLabel("Ronove", "value")
                ),
                new Cerberus(
                    H, "uptime",
                    new MyLabel("• Uptime", "name"),
                    new MyLabel("", "value")
                        .poll_command_sync(1000, "./scripts/get_uptime.sh")
                ),

                new MyBox(V, "pfp-image"),

                new Spacer(V)
            ),

            new MyBox(V, "dashboard").pack(
                new MyLabel("System Monitor", "title")
                    .expand_v(false),

                new MyBox(V, "sys-info").pack(

                    new Cerberus(
                        H, "mem-usage",
                        new MyLabel("• Memory", "name"),
                        new MyLabel("0", "value")
                            .poll_command_sync(1000, "./scripts/get_mem_usage.sh")
                    ),

                    new Cerberus(
                        H, "bat-level",
                        new MyLabel("• Battery", "name"),
                        new MyLabel("0", "value")
                            .poll_command_sync(1000, "./scripts/get_bat_level.sh")
                    ),

                    new Cerberus(
                        H, "volume",
                        new MyLabel("• Volume", "name"),
                        new MyLabel("0", "value")
                            .poll_command_sync(1000, "./scripts/get_volume.sh")
                    ),

                    new Cerberus(
                        H, "brightness",
                        new MyLabel("• Brightness", "name"),
                        new MyLabel("0", "value")
                            .poll_command_sync(1000, "./scripts/get_brightness.sh")
                    ),

                    new Cerberus(
                        H, "net-status",
                        new MyLabel("• Network", "name"),
                        new MyLabel("0", "value")
                            .poll_command_sync(1000, "./scripts/get_net_status.sh")
                    )
                ),
                new Spacer(V),
                new MyBox(V, "decor")
            )
        ).expand_v(false);

        /*
            Middle section
         */
        var center_box = new MyBox(V, "center-box").pack(
            new MyLabel("No players found", "mpris-metadata")
                .wrapping()
                .poll_command_sync(1000, "./scripts/get_mpris_metadata.sh")
        ).expand_v(false);

        /*
            Bottom section
         */
        var bottom_box = new MyBox(V, "bottom-box").pack(
            new MyBox(H, "web-shortcuts").even().pack(
                new MyButton("Youtube", "youtube")
                    .command_on_clicked("firefox https://youtube.com"),

                new MyButton("Netflix", "netflix")
                    .command_on_clicked("firefox https://netflix.com"),

                new MyButton("Spotify", "spotify")
                    .command_on_clicked("firefox https://spotify.com"),

                new MyButton("Reddit", "reddit")
                    .command_on_clicked("firefox https://reddit.com")
            ).gap(4)
        ).expand_v(false);
        
        append(header);
        append(top_box);
        append(center_box);
        append(bottom_box);
        append(new Spacer(V));
    }
}

