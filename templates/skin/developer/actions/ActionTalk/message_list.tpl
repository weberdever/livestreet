{**
 * Список сообщений
 *}

<table class="table table-talk">
	<thead>
		<tr>
			{if $bMessageListCheckboxes}
				<th class="cell-checkbox"><input type="checkbox" name="" class="input-checkbox" onclick="ls.tools.checkAll('form_talks_checkbox', this, true);"></th>
			{/if}
			<th class="cell-favourite"></th>
			<th class="cell-recipients">{$aLang.talk_inbox_target}</th>
			<th class="cell-title">{$aLang.talk_inbox_title}</th>
			<th class="cell-date ta-r">{$aLang.talk_inbox_date}</th>
		</tr>
	</thead>

	<tbody>
		{foreach from=$aTalks item=oTalk}
			{$oTalkUserAuthor = $oTalk->getTalkUser()}

			<tr>
				{if $bMessageListCheckboxes}
					<td class="cell-checkbox"><input type="checkbox" name="talk_select[{$oTalk->getId()}]" class="form_talks_checkbox input-checkbox" /></td>
				{/if}
				<td class="cell-favourite">
					<a href="#" onclick="return ls.favourite.toggle({$oTalk->getId()},this,'talk');" class="favourite {if $oTalk->getIsFavourite()}active{/if}"></a>
				</td>
				<td>
					{strip}
						{$aTalkUserOther = []}

						{foreach from=$oTalk->getTalkUsers() item=oTalkUser name=users}
							{if $oTalkUser->getUserId() != $oUserCurrent->getId()}
								{$aTalkUserOther[] = $oTalkUser}
							{/if}
						{/foreach}

						{foreach from=$aTalkUserOther item=oTalkUser name=users}
							{$oUser = $oTalkUser->getUser()}

							{if ! $smarty.foreach.users.first}, {/if}<a href="{$oUser->getUserWebPath()}" class="user {if $oTalkUser->getUserActive()!=$TALK_USER_ACTIVE}inactive{/if}">{$oUser->getLogin()}</a>
						{/foreach}
					{/strip}
				</td>
				<td>
					{strip}
						<a href="{router page='talk'}read/{$oTalk->getId()}/" class="js-title-talk" title="{$oTalk->getTextLast()|strip_tags|truncate:100:'...'|escape:'html'}">
							{if $oTalkUserAuthor->getCommentCountNew() or ! $oTalkUserAuthor->getDateLast()}
								<strong>{$oTalk->getTitle()|escape:'html'}</strong>
							{else}
								{$oTalk->getTitle()|escape:'html'}
							{/if}
						</a>
					{/strip}
					
					{if $oTalk->getCountComment()}
						({$oTalk->getCountComment()}{if $oTalkUserAuthor->getCommentCountNew()} +{$oTalkUserAuthor->getCommentCountNew()}{/if})
					{/if}

					{if $oUserCurrent->getId()==$oTalk->getUserIdLast()}
						&rarr;
					{else}
						&larr;
					{/if}
				</td>
				<td class="cell-date ta-r">{date_format date=$oTalk->getDate() format="j F Y, H:i"}</td>
			</tr>
		{/foreach}
	</tbody>
</table>