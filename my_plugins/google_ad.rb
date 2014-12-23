add_body_leave_proc do |date|
      r = %Q[<div class="adsense">]
      from_google = <<-EOS
<script type="text/javascript"><!--
google_ad_client = "ca-pub-5396337928320119";
/* blog3 */
google_ad_slot = "7480275847";
google_ad_width = 728;
google_ad_height = 90;
//-->
</script>
<script type="text/javascript"
src="//pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
EOS
      r << from_google
      r << %Q[</div>]
end
