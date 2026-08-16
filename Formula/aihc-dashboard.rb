class AihcDashboard < Formula
  desc "Read-only terminal dashboard for Baidu AIHC GPU resources"
  homepage "https://github.com/EasonAI-5589/cloud-gpu-dashboards"
  url "https://github.com/EasonAI-5589/cloud-gpu-dashboards/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "97b76e49657d2d3200c0ee06639c8246923524e5d89a21769f141adb6b649a26"
  license "MIT"

  depends_on "uv"

  def install
    libexec.install "aihc"
    (bin/"aihc").write <<~SH
      #!/bin/sh
      exec "#{formula_opt_bin("uv")}/uv" run --quiet --script "#{libexec}/aihc/scripts/aihc.py" "$@"
    SH
  end

  def caveats
    <<~EOS
      Configure the official AIHC CLI separately. By default the dashboard uses:
        ~/.agents/skills/aihccli/scripts/aihc-agent.sh

      Override it with AIHC_DASHBOARD_WRAPPER and the pool with
      AIHC_DASHBOARD_POOL.
    EOS
  end

  test do
    assert_match "aihc 2.3.0", shell_output("#{bin}/aihc --version")
  end
end
