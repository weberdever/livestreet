{**
 * Список заметок созданных пользователем
 *}

{extends file='layouts/layout.user.tpl'}

{block name='layout_user_page_title'}{$aLang.user_menu_publication}{/block}

{block name='layout_content'}
	{include file='navs/nav.user.created.tpl'}

	{if $aNotes}
		<table class="table table-profile-notes" cellspacing="0">
			{foreach from=$aNotes item=oNote}
				<tr>
					<td class="cell-username"><a href="{$oNote->getTargetUser()->getUserWebPath()}">{$oNote->getTargetUser()->getLogin()}</a></td>
					<td class="cell-note">{$oNote->getText()}</td>
					<td class="cell-date">{date_format date=$oNote->getDateAdd() format="j F Y"}</td>
				</tr>
			{/foreach}
		</table>
	{else}
		<div class="notice-empty">{$aLang.user_note_list_empty}</div>
	{/if}

	{include file='paging.tpl' aPaging=$aPaging}
{/block}