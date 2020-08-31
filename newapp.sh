#!/bin/bash
mypath="$HOME/Appdev_web/meteor-svelte/"
cd $mypath
meteor create $1
cd $1
# installing framework
echo "Project name: $1"
echo "installing framework in $1"
meteor npm i -S svelte
meteor remove blaze-html-templates
meteor add markdown svelte:compiler svelte:blaze-integration rdb:svelte-meteor-data static-html
mkdir -p imports/ui

# creating svelte template
sleep 1
echo creating svelte template
echo "<script>
    import { useTracker } from 'meteor/rdb:svelte-meteor-data'
    import { LoginWindow, Logout } from 'meteor/levelup:svelte-accounts-ui'
    import { create_bidirectional_transition, space } from 'svelte/internal'
    import {Thingies} from '../api/thingies'
    import Thingy from './thingies/Thingy.svelte'
    
    let newRes = ''
    
    function handleSubmit(evt) {
        Thingies.insert({
            title: newRes
        })
        // /!\ don't forget to empty the resoluton string after commit
        newRes=''
    }
    // function removeRes(evt) {}
    
    $: thingies = useTracker(() => Thingies.find({}).fetch())
    $: user = useTracker(() => Meteor.user())
    $: userId = useTracker(() => Meteor.userId())
    // $: thingies.length ? 
</script>

<header>
    <h1 class='text-center mt-5 mb-4'>Thingies</h1>
    <div class='row my-4'>
        <div class='col-lg-6 mx-auto '>
            {#if $user}
                {#if $userId}
                     <h2>{$userId}</h2>
                     <Logout />
                {:else}
                    <h3 class='alert alert-danger'>user id not found</h3>
                {/if}
            {:else}
                 <LoginWindow />
            {/if}
        </div>
    </div>
    
    <form 
        class='mb-4' 
        on:submit|preventDefault={handleSubmit} 
        action='GET'>
        <div class='w-50 mx-auto mb-4'>
            <input 
                class=' mb-2 form-control' 
                type='text' 
                bind:value={newRes}
                placeholder='Add a thingy:'>
            <input class=' mb-2 btn btn-block btn-secondary' type='submit' value='submit'>

        </div>
    </form>

    {#if $thingies.length}
        {#each $thingies as thingy, i}
            <Thingy {thingy} {i} />
        {/each}
    {:else}
        <h2 class="alert alert-danger"><span class="container">no thingy yet</span></h2>
    {/if}

</header>

    " > imports/ui/App.svelte
# setting fw up
sleep 1
echo setting fw up
echo "import { Meteor } from 'meteor/meteor' 
import App from '../imports/ui/App.svelte'
Meteor.startup(() => {
  new App({
      target: document.getElementById('app')
        })
})
" > client/main.js

# creating main html page
sleep 1
echo creating main html page
echo "<head>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
    <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' integrity='sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z' crossorigin='anonymous'>
      <title>$1</title>
      </head>

      <body>
        <div id='app'></div>
	</body>
" > client/main.html
# backend 
sleep 1
echo creating database
echo "import {Mongo} from 'meteor/mongo'

export const Thingies = new Mongo.Collection('thingies')
" > imports/api/thingies.js

echo "import { Meteor } from 'meteor/meteor';
import '../imports/api/thingies'

Meteor.startup(() => {
  
});
" > server/main.js

echo "<script>
    // import {createEventDispatcher} from 'svelte'
    import {Thingies} from '../../api/thingies'
    export let thingy
    export let i
    let updateRes = thingy.title

    let display = 'btn'

    // const dispatch = createEventDispatcher()

    function deleteRes() {
        Thingies.remove(thingy._id)
        // dispatch('delete', i)
    }
    function handleUpdate(evt) {
        changeDisplay()
        Thingies.update({
            _id: thingy._id
        },{
                
            title: updateRes
        })
    }
    function changeDisplay () {
        display === 'btn' ? display = 'input' : display = 'btn'
    }

</script>
<div class='mx-auto w-50 alert alert-{i%2 == 0 ? 'success' : 'warning'} '>
    <h2 class='container'>{thingy.title}</h2>
    <div class='float-right'>
        {#if display === 'btn'}
            <button on:click={changeDisplay} class='badge border-0 badge-pill badge-warning'>&#9889;</button>
            |
            <span class='badge badge-pill badge-danger' on:click={deleteRes} >&times;</span>
        {:else}
            <form on:submit|preventDefault={handleUpdate}>
                <input type='text' bind:value={updateRes} placeholder={updateRes} >
                <h6 class='badge badge-pill badge-primary' on:click={handleUpdate} type='submit'>Update</h6>
                <h6 class='badge badge-pill badge-secondary' on:click={changeDisplay} >cancel</h6>
            </form>
        {/if}

    </div>
    
    <slot />
</div>

<style>
    h2 {
        display: inline;
    }
    .delete {
        cursor: pointer;
    }

    .delete:hover {
        font-weight: bold;
    }
    
</style>" > imports/ui/thingies/Thingies.svelte
sleep 1
echo open and launch
code ./

meteor
