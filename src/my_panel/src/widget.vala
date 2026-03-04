namespace CustomWidgets {
    // Orientation
    public const Gtk.Orientation H = Gtk.Orientation.HORIZONTAL;
    public const Gtk.Orientation V = Gtk.Orientation.VERTICAL;

    // Alignment
    public const Gtk.Align S = Gtk.Align.START;
    public const Gtk.Align C = Gtk.Align.CENTER;
    public const Gtk.Align E = Gtk.Align.END;
    public const Gtk.Align F = Gtk.Align.FILL;

    /*
        Container widget
     */
    public class MyBox : Gtk.Box {
        public MyBox(Gtk.Orientation orientation = H, string? css_class = null) {
            Object(orientation: orientation);

            if (css_class != null)
                css(css_class);
        }

        public MyBox css(string css_class) {
            add_css_class(css_class);

            return this;
        }

        public MyBox even(bool enable = true) {
            homogeneous = enable;

            return this;
        }

        public MyBox expand_h(bool enable = true) {
            hexpand = enable;

            return this;
        }

        public MyBox expand_v(bool enable = true) {
            vexpand = enable;

            return this;
        }

        public MyBox gap(int size = 0) {
            spacing = size;

            return this;
        }

        public MyBox pack(params Gtk.Widget[] widgets) {
            foreach (var w in widgets)
                append(w);

            return this;
        }
    }

    /*
        Label widget 
     */
    public class MyLabel : MyBox {
        private Gtk.Label label;
        private GLib.SourceFunc cb;
        private uint timeout_id = 0;

        public MyLabel(string text, string? css_class = null) {
            base(V, css_class);

            label = new Gtk.Label(text);
            label.vexpand = true;

            append(label);
        }

        ~MyLabel() {
            stop_poll();
        }

        public MyLabel text(string text = "") {
            label.label = text;

            return this;
        }

        public MyLabel max_width(int len = -1) {
            label.max_width_chars = len;

            return this;
        }

        public MyLabel wrapping(bool enable = true) {
            label.wrap = true;

            return this;
        }

        public MyLabel align_h(Gtk.Align align = S) {
            halign = align;

            return this;
        }

        public MyLabel align_v(Gtk.Align align = C) {
            valign = align;

            return this;
        }

        // You can use this to periodically update the label text
        public MyLabel poll_command_sync(uint interval_ms, string command) {
            stop_poll();

            cb = () => {
                string cmd = command;

                if (cmd == null || cmd.strip() == "")
                {
                    this.text("EXCEPTION: null command");

                    return false;
                }

                try {
                    string out_str;
                    string err_str;
                    int status;

                    Process.spawn_command_line_sync(
                        cmd,
                        out out_str,
                        out err_str,
                        out status
                    );

                    this.text(status == 0 ? out_str.strip() : "FAILED: " +  err_str.strip());
                } catch (Error e) {
                    this.text("EXCEPTION: " + e.message);

                }

                return true; // Continue the timer

            };

            // Execute once to initialize the label text
            cb();

            timeout_id = GLib.Timeout.add(interval_ms, cb);

            return this;
        }

        public void stop_poll() {
            if (timeout_id != 0)
            {
                GLib.Source.remove(timeout_id);
                timeout_id = 0;
            }
        }
    }

    /*
        Button widget
     */
    public class MyButton : MyBox {
        private Gtk.Button button;
        private string cmd;

        public MyButton(string text, string? css_class = null) {
            base(V, css_class);

            button = new Gtk.Button.with_label(text);
            button.vexpand = true;

            append(button);
        }

        public MyButton command_on_clicked(string command) {
            cmd = command;

            button.clicked.connect(() => {
                on_clicked();
            });

            return this;
        }

        private void on_clicked() {
            if (cmd == null || cmd.strip() == "")
            {
                /* Do something */

                return;
            }

            try {
                Process.spawn_command_line_async(cmd);
            } catch (Error e) {
                /* Do something */
            };
        }
    }

    /*
        Transparent widget for placement
     */
    public class Spacer : MyBox {
        public Spacer(Gtk.Orientation orientation = H) {
            Object(orientation: orientation);

            hexpand = (orientation == H);
            vexpand = !hexpand;
        }
    }

    /*
        ----------------------------------
        - Start Box <- Spacer -> End Box -
        ----------------------------------
     */
    public class Cerberus : MyBox {
        public Cerberus(
            Gtk.Orientation orientation = H,
            string? css_class = null,
            MyBox? start = null,
            MyBox? end = null
        ) {
            base(orientation, css_class);
            
            append(start ?? new MyBox());
            append(new Spacer(orientation));
            append(end ?? new MyBox());
        }
    }
}

