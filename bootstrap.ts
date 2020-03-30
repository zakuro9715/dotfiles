import { join } from 'https://deno.land/std/path/mod.ts'
import { exists, ensureSymlink } from 'https://deno.land/std/fs/mod.ts'

const env = Deno.env()
const home = env['HOME']
const path = env['PATH']
const xdgConfigHome = env['XDG_CONFIG_HOME']

function showWelcomeMessage() {
  console.log(`
      DDDDDDDD      OOOOOOO   TTTTTTTTTTT   FFFFFFFFF  IIIIIIIIIII   LL         EEEEEEEEEE   SSSSSSS
     DD      DD   OO      OO      TT       FF              II       LL         EE          SS
    DD      DD   OO      OO      TT       FF              II       LL         EE            SS
   DD      DD   OO      OO      TT       FFFFFFFFF       II       LL         EEEEEEEEEE       SS
  DD      DD   OO      OO      TT       FF              II       LL         EE                 SS
 DDDDDDDDD      OOOOOOO       TT       FF          IIIIIIIIIII  LLLLLLLLL  EEEEEEEEEE    SSSSSSS

####################################################################################################
`)
}

interface ExecOptions {
  cwd?: string,
  env?: { [key: string]: string },
  stdin?: Deno.ProcessStdio | number
  stdout?: Deno.ProcessStdio | number
  stderr?: Deno.ProcessStdio | number
  devnull?: boolean | 'stdout' | 'stderr'
}

const exec = async (cmd: string | string[], opts: ExecOptions = {})  => {
  return Deno.run({
    cmd: typeof cmd === 'string' ? [ cmd ] : cmd,
    stdin: opts.stdin,
    stdout: opts.stdout || (opts.devnull == 'stdout' ? 'null' : 'inherit'),
    stderr: opts.stdout || (opts.devnull == 'stdout' ? 'null' : 'inherit'),
  }).status()
}

const checkCommand = async (cmd: string) =>
  await exec(['sh', '-c', `type ${cmd}`], { devnull: true })


function error(msg: string) {
  console.error(`Error ${msg}`)
  Deno.exit(1)
}

function warn(msg: string) {
  console.warn(`Warn ${msg}`)
}

function info(msg: string) {
  console.log(`Info: ${msg}`)
}

function success(msg: string) {
  console.log(`Success: ${msg}`)
}

function assert(test: boolean, msg?: string) {
  if (msg) {
    console.error(`Internal error: ${msg}`)
  }
  console.trace()
}

function internalError(msg?: string) {
  assert(false, msg)
}


function verifySystem() {
  const requiredCommands = ['git', 'zsh', 'go']
  requiredCommands.forEach((cmd) => {
    if (!checkCommand(cmd)) {
      error(`Cannot found ${cmd}`)
    }
  })

  success("Complete system verification.")
}

interface InstallOptions {
  env: { [key: string]: string },
  name: string,
  cmd: string | string[],
}

async function doInstall(opts: InstallOptions ) {
  if ((await exec(opts.cmd, { env: opts.env } )).success) {
    success(opts.name)
  } else {
    error(opts.name)
  }
}

const requiredGoPackages = [
  "github.com/github/hub",
  "github.com/motemen/ghq",
]

const requiredRepositories = [
  "zsh-users/zsh-completions",
]

showWelcomeMessage()
verifySystem()

function installPackages() {
  const env = Deno.env()
  const gopath = env['home']

  requiredGoPackages.forEach((pkg) => doInstall({ env: { GOPATH: gopath }, name: pkg, cmd: ['go', 'get', pkg] }))
  requiredRepositories.forEach((repo) => doInstall({ env :{ PATH: join(gopath, 'bin') + ':' + path }, name: 'repo', cmd: ['ghq', 'get', repo]}))
}

async function removeLinkIfExists(dest: string, force = false) {
  if (await exists(dest)) {
    const fileInfo = await Deno.lstat(dest)
    if (fileInfo.isSymlink())
    {
      info(`Removing ${dest}`)
      Deno.remove(dest)
    } else {
      error(`File ${dest} already exists`)
    }
  }
}

interface srcDest {
  src: string,
  dest: string,
}

async function createOrUpdateSymlink({ src, dest }: srcDest, force = false) {
  await removeLinkIfExists(dest, force)

  info(`Creating ${dest}`)
  await ensureSymlink(src, dest)
}


async function createSymlinks(configs: srcDest[], force = false) {
  configs.forEach(async ({ src, dest }) => {
    (await Deno.readdir(src)).forEach((f) => {
      if (typeof f.name === 'string') {
        createOrUpdateSymlink({ src: join(src, f.name), dest: join(dest, f.name) })
      } else {
        internalError('filename is null')
      }
    })
  })
}

try {
  await createSymlinks([{ src: './home', dest: home }, { src: 'xdg_home', dest: xdgConfigHome }])
} catch {
  internalError('error')
}
