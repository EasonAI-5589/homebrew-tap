class AlipaiDashboard < Formula
  desc "Read-only terminal dashboard for Alibaba Cloud PAI GPU resources"
  homepage "https://github.com/EasonAI-5589/cloud-gpu-dashboards"
  url "https://github.com/EasonAI-5589/cloud-gpu-dashboards/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "97b76e49657d2d3200c0ee06639c8246923524e5d89a21769f141adb6b649a26"
  license "MIT"

  depends_on "uv"

  def install
    libexec.install "alipai"
    (bin/"alipai").write <<~SH
      #!/bin/sh
      exec "#{Formula["uv"].opt_bin}/uv" run --quiet --script "#{libexec}/alipai/scripts/alipai.py" "$@"
    SH
  end

  def caveats
    <<~EOS
      Configure the AliPAI SSH host and credential preflight separately.
      No cloud credentials are included in this package.
    EOS
  end

  test do
    assert_match "alipai 3.0.0", shell_output("#{bin}/alipai --version")
  end
end
