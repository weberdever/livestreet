{**
 * Результаты поиска
 *}

{extends file='layouts/layout.base.tpl'}

{block name='layout_page_title'}{$aLang.search_results}{/block}

{block name='layout_content'}
	{include file='forms/form.search.main.tpl'}

	{if $bIsResults}
		<ul class="nav nav-pills">
			{foreach from=$aRes.aCounts item=iCount key=sType name="sTypes"}
				<li {if $aReq.sType == $sType}class="active"{/if}>					
					<a href="{router page='search'}{$sType}/?q={$aReq.q|escape:'html'}">
						{$iCount} 
						{if $sType=="topics"}
							{$aLang.search_results_count_topics}
						{elseif $sType=="comments"}
							{$aLang.search_results_count_comments}
						{else}
							{hook run='search_result_item' sType=$sType}
						{/if}
					</a>
				</li>				
			{/foreach}
		</ul>
		

		{if $aReq.sType == 'topics'}
			{include file='topics/topic_list.tpl'}
		{elseif $aReq.sType == 'comments'}
			{include file='comments/comment_list.tpl'}
		{else}
			{hook run='search_result' sType=$aReq.sType}
		{/if}
	{else}
		{$aLang.search_results_empty}
	{/if}
{/block}