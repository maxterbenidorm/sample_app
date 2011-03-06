function countMicropostLength()
{
	$("char_number").update(140 - $("micropost_content").textLength);
	
	/*if (char_number.textContent < 0)
	{
		char_number.style = "color: red";
	}
	else
	{
		char_number.style = "color: black";
	}*/
}