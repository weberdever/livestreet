{**
 * Личное сообщение
 *}

{extends file='layouts/layout.user.messages.tpl'}

{block name='layout_content'}
	{assign var="oUser" value=$oTalk->getUser()}


	<article class="topic topic-type-talk">
		<header class="topic-header">
			<h1 class="topic-title">{$oTalk->getTitle()|escape:'html'}</h1>
			
			<div class="topic-info">
				<a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(48)}" width="32px" alt="avatar" class="avatar" /></a>
				<p class="author-wrapper"><a href="{$oUser->getUserWebPath()}" class="author">{$oUser->getLogin()}</a>
					<time datetime="{date_format date=$oTalk->getDate() format='c'}" pubdate>
						{date_format date=$oTalk->getDate() format="j F Y, H:i"}
					</time>
				</p>
				<p>
					{$aLang.talk_speaker_title}:
					
					{foreach from=$oTalk->getTalkUsers() item=oTalkUser name=users}
						{assign var="oUserRecipient" value=$oTalkUser->getUser()}
						{if $oUser->getId() != $oUserRecipient->getId()}
							<a class="{if $oTalkUser->getUserActive() != $TALK_USER_ACTIVE}inactive{/if}" href="{$oUserRecipient->getUserWebPath()}">{$oUserRecipient->getLogin()}</a>{if !$smarty.foreach.users.last}, {/if}
						{/if}
					{/foreach}

					{if $oTalk->getUserId()==$oUserCurrent->getId() or $oUserCurrent->isAdministrator()}
						&nbsp;&nbsp;&nbsp;<a href="#" class="link-dotted" onclick="jQuery('#talk_recipients').toggle(); return false;">{$aLang.talk_speaker_edit}</a>
					{/if}
				</p>
			</div>
		</header>
		
		
		{**
		 * Участники личного сообщения
		 *}

		{if $oTalk->getUserId()==$oUserCurrent->getId() or $oUserCurrent->isAdministrator()}
			<div class="talk-recipients" id="talk_recipients">
				<h3>{$aLang.talk_speaker_title}</h3>

				<form onsubmit="return ls.talk.addToTalk({$oTalk->getId()});">
					<p><label for="talk_speaker_add">{$aLang.talk_speaker_add_label}:</label>
					<input type="text" id="talk_speaker_add" name="add" class="input-text input-width-300 autocomplete-users-sep" /></p>
					<input type="hidden" id="talk_id" value="{$oTalk->getId()}" />
				</form>

				<div id="speaker_list_block">
					{if $oTalk->getTalkUsers()}
						<ul class="list" id="speaker_list">
							{foreach from=$oTalk->getTalkUsers() item=oTalkUser name=users}
								{if $oTalkUser->getUserId()!=$oUserCurrent->getId()}
									{assign var="oUser" value=$oTalkUser->getUser()}

									{if $oTalkUser->getUserActive()!=$TALK_USER_DELETE_BY_AUTHOR}
										<li id="speaker_item_{$oTalkUser->getUserId()}_area">
											<a class="user {if $oTalkUser->getUserActive()!=$TALK_USER_ACTIVE}inactive{/if}" href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
											{if $oTalkUser->getUserActive()==$TALK_USER_ACTIVE}- <a href="#" id="speaker_item_{$oTalkUser->getUserId()}" class="delete">{$aLang.blog_delete}</a>{/if}
										</li>
									{/if}
								{/if}
							{/foreach}
						</ul>
					{/if}
				</div>
			</div>
		{/if}
		
		
		<div class="topic-content text">
			{$oTalk->getText()}
		</div>
		
		
		<footer class="topic-footer">
			<ul class="topic-info">
				<li class="topic-info-favourite"><a href="#" onclick="return ls.favourite.toggle({$oTalk->getId()},this,'talk');" class="favourite {if $oTalk->getIsFavourite()}active{/if}"></a></li>
				<li class="delete"><a href="{router page='talk'}delete/{$oTalk->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" onclick="return confirm('{$aLang.talk_inbox_delete_confirm}');" class="delete">{$aLang.delete}</a></li>
				{hook run='talk_read_info_item' talk=$oTalk}
			</ul>
		</footer>
	</article>

	{assign var="oTalkUser" value=$oTalk->getTalkUser()}

	{if !$bNoComments}
		{include
			file='comments/comment_tree.tpl'
			iTargetId=$oTalk->getId()
			sTargetType='talk'
			iCountComment=$oTalk->getCountComment()
			sDateReadLast=$oTalkUser->getDateLast()
			sNoticeCommentAdd=$aLang.topic_comment_add
			bNoCommentFavourites=true}
	{/if}
{/block}