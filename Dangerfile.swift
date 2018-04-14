import Danger
import CompatabilityDetection // package: https://github.com/vknabel/CompatabilityDetection

let mayHaveAddedProjects = danger.github.modifiedFiles.contains("README.md")

if (mayHaveAddedProjects) {
    let diffUrl = "https://github.com/\(danger.github.pullRequest.fullName)/pull/\(danger.github.pullRequest.number)"
    let results = compatabilityTestAdditionsForUrl(diffUrl)
    for (repo, error) in results {
        #if os(Linux)
        let osName = "Linux"
        #else
        let osName = "macOS"
        #endif
        fail("\(repo.name) seems to be incompatible with \(osName): \(error)")
    }
}
