function morning_announcement_compile() {
	var statusTar = document.getElementById("morning_loading");
	var listTar = statusTar.nextElementSibling;

	var calList = new Array();
	var ele = listTar.firstElementChild;
	var counter = 0;
	var limit = 10;
	while(counter < limit && ele != null) {
		ele.style.display = "none";
		var firstChild;

		if(ele.childElementCount > 0) {
			firstChild = ele.firstElementChild;
			if(firstChild.tagName.toUpperCase() == "STRONG") {
				var date = firstChild.innerHTML;
				var dateObj = new Date(date);
				let newObj = {
					day_color: firstChild.nextElementSibling.innerHTML.charAt(0).toUpperCase(),
					date_accus: date,
					date_weekday: parseWeekDay(dateObj.getDay()),// 0-6 Sun to Sat
					date: dateObj,
					seq: counter++
				}
				calList.push(newObj);
				embed(newObj);
			}
		}
		ele = ele.nextElementSibling;
	}
	console.log(calList);
	function embed(obj) {
		var targetEle = document.getElementById("morning_list");
		var newEntry = document.createElement("li");
		newEntry.className = "link list-group-item";
		newEntry.setAttribute("date-seq", obj.seq);
		
		var newLink = document.createElement("a");
		newLink.href = "javascript:loadMorningAnnouncement("+obj.seq+")";
		newLink.innerHTML = obj.date_accus + ", " + obj.day_color + ", " + obj.date_weekday;
		newEntry.appendChild(newLink);
		targetEle.appendChild(newEntry);
	}
	function parseMonth(month) {
		return new Array("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC").indexOf(month.substr(0, 3).toUpperCase())+1;
	}
	function parseWeekDay(number) {
		console.log(number);
		return new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday" ,"Saturday")[parseInt(number)];
	}
	// show today's announcement
	loadMorningAnnouncement(0);
	statusTar.style.display = "none";
}
function loadMorningAnnouncement(seq) {
	var statusTar = document.getElementById("morning_loading");
	var listTar = statusTar.nextElementSibling;
	
	listTar.style.opacity = 1;
	//hide all first
	for(let i = 0; i < listTar.childElementCount; i++)
		listTar.children[i].style.display = "none";

	var recursiveRef = listTar.getElementsByTagName("STRONG")[seq].parentElement;
	do {
		recursiveRef.style.display = "block";
		recursiveRef = recursiveRef.nextElementSibling;
		// console.log(recursiveRef);
	}
	while(recursiveRef != null && recursiveRef.tagName.toUpperCase()!="HR");
	
}