<!DOCTYPE html>
<html>
	<head>
		<!-- nikuda by sagi 6/2005 -->
		<!-- updated by doron 6/2010 -->
		<!-- updated by mark 10/2013 -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>nIkUdA נִקֻּדַהּ</title>
		<link rel="shortcut icon" href="php/favicon.ico"/>
		<meta content="נקדה, תכנה לניקוד אוטומט" name="description" />
		<meta content="ניקוד, נקדה, אוטומט, עברית, נקדן, נקד, תכנה, תוכנה, חופשי, חפשי ,<key words>" name="keywords" />
		<meta content="follow,index,imageindex" name="robots" />
		<meta content="all audiences" name="rating" />
		<meta content="Sagi Shoval" name="author" />
		<link rel="Stylesheet" type="text/css" href="css/nikuda.css" />
		<script src="js_tp/jquery-1.5.min.js" type="text/javascript"></script>
		<script src="js/nikuda.js" type="text/javascript"></script>
	</head>
	<body dir="rtl">
		<img class="nikuda_label" src="images/nikuda.gif" alt="נִקֻּדַהּ"/>
		<div class="access">
			<input id="NikudizeButton" type="button" class="access_button" value="נקד פסקה שלמה" title="נקד את כלל המלל בתיבה שמתחת" disabled="disabled" tabindex="2"/>
			<textarea class="access_text" id="MainText" style="font-size:1em; resize:none" rows="10" cols="50" disabled="disabled" tabindex="1"></textarea>
			<div class="access_separator"></div>
			<input id="QuickyButton" type="button" class="access_button" value="נקד מילה בודדת, אוטומטית" title="נקד את המילה הבודדת בשורה שמתחת" disabled="disabled" tabindex="3" />
			<input class="access_text" id="Quicky" type="text" disabled="disabled" tabindex="4"/>
			<div>
				<div id="SuggestionBox" style="display:none">
					<table style="width:100%" summary='header'>
						<tbody>
							<tr>
								<td>
									<ul id="SuggestionList" style="color:black">
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="access_separator"></div>
			<div id="MeNaked" style="display:none">
				<div class ="access_text" id="QuickyAns" style="text-align:center; margin: 8% auto">
					<!-- quicky answer -->
				</div>
				<div style="width:95%; margin:auto; overflow:hidden">
					<img class="nikud_button" src="images/nikud_0.svg" alt="&#187;" onclick="insert_Draft(' ');" title="נקה ניקוד"/>
					<img class="nikud_button" src="images/nikud_1.svg" alt="שׂ" onclick="insert_Draft('ׂ');" title="שׂין"/>
					<img class="nikud_button" src="images/nikud_2.svg" alt="שׁ" onclick="insert_Draft('ׁ');" title="שׁין"/>
					<img class="nikud_button" src="images/nikud_3.svg" alt="ֻ" onclick="insert_Draft('ֻ');" title="קובוץ"/>
					<img class="nikud_button" src="images/nikud_4.svg" alt="ּ" onclick="insert_Draft('ּ');" title="דּגש, שוּרוק, מפיק"/>
					<img class="nikud_button" src="images/nikud_5.svg" alt="ֹ" onclick="insert_Draft('ֹ');" title="חולם מלא"/>
					<img class="nikud_button" src="images/nikud_6.svg" alt="ָ" onclick="insert_Draft('ָ');" title="קָמץ"/>
					<img class="nikud_button" src="images/nikud_7.svg" alt="ַ" onclick="insert_Draft('ַ');" title="פַתח"/>
					<img class="nikud_button" src="images/nikud_8.svg" alt="ֶ" onclick="insert_Draft('ֶ');" title="סֶגול"/>
					<img class="nikud_button" src="images/nikud_9.svg" alt="ֵ" onclick="insert_Draft('ֵ');" title="צֵירי"/>
					<img class="nikud_button" src="images/nikud_B.svg" alt="ִ" onclick="insert_Draft('ִ');" title="חִיריק"/>
					<img class="nikud_button" src="images/nikud_C.svg" alt="ֳ" onclick="insert_Draft('ֳ');" title="חטף קֳמץ"/>
					<img class="nikud_button" src="images/nikud_D.svg" alt="ֲ" onclick="insert_Draft('ֲ');" title="חטף פֲתח"/>
					<img class="nikud_button" src="images/nikud_E.svg" alt="ֱ" onclick="insert_Draft('ֱ');" title="חטף סֱגול"/>
					<img class="nikud_button" src="images/nikud_F.svg" alt="ְ" onclick="insert_Draft('ְ');" title="שְווא"/>
				</div>
				<div class="access_text" id="Draft" style="font-size:3em; cursor:pointer; text-align:center; margin: 0">
					<!-- draft -->
				</div>
				<input id="DraftUpdateButton" type="button" class="access_button" value="עדכן מילה לתוצאה" title="עדכן מילה שנֻקדה לתוצאה" style="margin:0" tabindex="5"/>
				<!--<input id="SelectAll" type="button" class="access_button" value="העתק תוצאה" title="בחר בכל הטקסט שנֻקד" tabindex="6"/>-->
			</div>
			<input id="Status" type="text" disabled="disabled" style="width:100%"/>
		</div>
		<div class="answer_text">
			<!--div>
				תוצאה:
			</div-->
			<br/>
			<div id="Answer">
				<!-- answer -->
			</div>
		</div>
		<div class="help" id="HelpBox" onclick="$(this).toggle('slow');">
			<h1>דַּע נִקֻּדַהּ</h1>
			<br />
			<br />
			<b><em>לחצן "נקד פסקה שלמה"</em></b><br />
			הכניסו את הטקסט שברצונכם לנקד לתיבה שמתחתי. לחצו עלי לניקודו.<br />
			אם מילה כלשהי בטקסט המנוקד אינה מנוקדת כמו שהתכוונתם, הקליקו עליה עד לקבלת תצורת
			הניקוד הנכונה.<br />
			<br />
			<b><em>לחצן "נקד מילה בודדת, אוטומטית"</em></b><br />
			כיתבו מילה כלשהי בתיבה שמתחתי. לחיצה עלי תציג את אפשרויות הניקוד השונות למילה זו.<br />
			מופרדות ברווחים, ניתן לנקד מספר מילים המופרדות ברווחים."<br />
			<br />
			<b><em>לחצן "עדכן מילה לתוצאה"</em></b><br />
			אני שימושי אם תרצו לעדכן תצורת ניקוד חדשה שאינה מופיעה במאגר המילים של ניקודה.
			<br />
			קודם כל יש ללחוץ על המילה שתרצו לעדכן בטקסט המנוקד משמאל. (אם לא לחצתם קודם על מילה
			בטקסט המנֻקד: אין לי כל שימוש!)
			<br />
			המילה תופיע בתיבת הטיוטא מעליי. שם תוכלו לנקד אותה כרצונכם.
			<br />
			בכדי לעדכנה בחזרה לטקסט המנוקד ליחצו עלי.<br />
			<br />
			<b><em>לחצן "העתק תוצאה"</em></b><br />
			ליחצו עליי בכדי לסמן את התוצאה המנֻקדת.
			<br />
			<b><em>שתי דרכים לניקוד מילה בתיבת הטיוטא:</em></b><br />
			<b>א.</b> ידנית ע"י שימוש בלחיצי הניקוד מתחת לתיבת הטיוטא (ישנם גם קיצורי דרך בצורת שילובי מקשים, נסו ללחוץ על ctrl+shift ועל מקש מהשורה הראשונה של המקלדת, דהיינו שורת המספרים, ניקודי שׁ שׂ נעשים ע"י לחיצה על ctrl+shift+ש'.)<br />
			<b>ב.</b> חצי-אוטומטית בעזרת תיבת "נקד בודדת":
			<blockquote>
			כיתבו בתיבת "נקד בודדת" <i>מילה דומה</i> למילה שתרצו לנקד, לחצו על "נקד בודדת" ובדקו
			אם ניקודה משביע את רצונכם. אם כן, לחיצה על תצורת הניקוד המתאימה תועתק לתיבת הטיוטא.<br />
			<i>מילה דומה</i> היא <b>או</b> מילה באורך זהה למילה בתיבת הטיוטא (למשל בשביל לנקד
			את המילה "ינקדו" בתיבת הטיוטא, נקדו בודדת את "ילמדו" ובחרו בתצורה המתאימה) <b>או</b>
			מילה חלקית למילה בתיבת הטיוטא (למשל בשביל לנקד את המילה "נקדתם" בתיבת הטיוטא, נקדו
			בודדת את "נקדת", אח"כ נקדו בודדת את "תם"- ונשלם!).
			</blockquote>
			<br />
			<b><em>איך נִקֻּדַהּ עובדת?</em></b><br />
			נִקֻּדַהּ אינה יודעת כללי ניקוד כלשהם. היא פשוט זוכרת את הניקוד של כל המילים שהיא
			ראתה. (כרגע מכיל בסיס הנתונים את כל מילות התנ"ך, שירי רחל, שירי ביאליק, לקסיקונים
			ומשוררים אחרים).<br />
			<!--
			המילים החדשות שאתם מוסיפים נשמרות לשימושכם אצלכם על המחשב, אולם משתמשים במחשבים
			אחרים לא יכולים לגשת אליהן.<br />
			<br />
			<b><em>עדכון בסיס הנתונים לטובת כלל המשתמשים</em></b><br />
			רצוי ומשתלם לעדכן את כלל משתמשי נִקֻּדַהּ במילים החדשות שנאספו אצלכם על המחשב

			<em>ניתן להשתמש גם בכל טקסט עברי מנוקד שברשותכם</em>.<br />
			כרגע אפשרות זאת קיימת רק עבור משתמשים רשומים<br />
			בכדי לקבל רשות להוסיף למאגר הניקוד נא לפנות למייל בתחתית הרשימה<br />
			-->
			<p style="text-align: left">
				<b>נִקֻּדַהּ 10/6/2005 </b><br /><br />
				<b>לזכרו של שׁוֹבָל שַׂגִּיא כ"ח באב התשל"ה - כ" באב התשס"ט, מאהב אמת של השפה העברית ובנות אדם </b><br />
				<a href="http://www.hebcal.com/converter/?hd=28&amp;hm=Av&amp;hy=5735&amp;h2g=Convert+Hebrew+to+Gregorian+date"> תרגום תאריכים לועזי עברי</a>
				<br /><br /><br /><br />לטענות מענות ובקשות לשיפור ניתן לפנות ל
				<!--a href="mailto:veltzerdoron@gmail.com">דורון</a-->
				<a href="https://bitbucket.org/veltzer/nikuda/issues">הצעות לשיפור</a>
			</p>
		</div>
	</body>
</html>
