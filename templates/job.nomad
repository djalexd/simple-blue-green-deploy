job "{{ job }}" {
	datacenters = ["dc1"]
	priority = 50

	group "blue" {
	  count = {{ count_blue | default(defaults_count_blue) }}
		task "runtime" {
			driver = "docker"
			config {
				image = "{{ image_name }}:{{ version_blue | default('latest') }}"
				port_map { http = {{ port | default(defaults_app_port) }} }
			}
			service {
				tags = ["{{ tags_blue | list | join('","') }}"]
				name = "${{'{'}}JOB{{'}'}}"
				port = "http"
				check { type = "tcp" port = "http" interval = "10s" timeout  = "2s" }
			}
			resources {
				cpu = {{ cpu | default(defaults_cpu) }}
				memory = {{ memory | default(defaults_memory) }}
				network { mbits = 30 port "http" {} }
			}
		}
	}

	group "green" {
	  count = {{ count_green | default(defaults_count_green) }}
		task "runtime" {
			driver = "docker"
			config {
				image = "{{ image_name }}:{{ version_green | default('latest') }}"
				port_map { http = {{ port | default(defaults_app_port) }} }
			}
			service {
				tags = ["{{ tags_green | list | join('","') }}"]
				name = "${{'{'}}JOB{{'}'}}"
				port = "http"
				check { type = "tcp" port = "http" interval = "10s" timeout  = "2s" }
			}
			resources {
				cpu = {{ cpu | default(defaults_cpu) }}
				memory = {{ memory | default(defaults_memory) }}
				network { mbits = 30 port "http" {} }
			}
		}
	}
}
