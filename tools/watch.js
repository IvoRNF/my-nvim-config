const fs = require('fs');
const { execSync, spawn } = require('child_process');
const fname = './change.signal';

async function main() {
  if (!fs.existsSync(fname)) {
    startCommand();
  }
  while (true) {
    if (fs.existsSync(fname)) {
      console.log('building...');
      const output = execSyncCommand('yarn build:fast');
      output && console.log(output.toString());
      fs.unlinkSync(fname);
      startCommand();
    }

    await new Promise((resolve, reject) => {
      setTimeout(() => resolve(null), 2000);
    });
  }
}

function startCommand() {
  const fnamePid = './pid';
  if (fs.existsSync(fnamePid)) {
    const pid = Number(fs.readFileSync(fnamePid).toString());
    try {
      process.kill(-pid);
      child = null;
      console.log('killed');
    } catch (err) {}
  }
  const child = spawnCommand('yarn', ['start']);
  fs.writeFileSync(fnamePid, child.pid.toString());
  return child;
}

function spawnCommand(command, args) {
  const childProcess = spawn(command, args, {
    detached: true,
  });
  childProcess.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`);
  });

  childProcess.stderr.on('data', (data) => {
    console.error(`stderr: ${data}`);
  });

  childProcess.on('close', (code) => {
    console.log(`child process exited with code ${code}`);
  });
  return childProcess;
}

function execSyncCommand(command) {
  return execSync(command, (error, stdout, stderr) => {
    if (stdout) {
      console.log(stdout);
    }
    if (error) {
      console.error(`exec error: ${error}`);
      return;
    }
    if (stderr) {
      console.error(`stderr: ${stderr}`);
    }
    console.log(`stdout: ${stdout}`);
  });
}

main();
