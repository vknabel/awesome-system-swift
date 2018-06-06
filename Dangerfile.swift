import Danger
import CompatabilityDetection // marathon:https://github.com/vknabel/CompatabilityDetection.git

let mayHaveAddedProjects = danger.github.modifiedFiles.contains("README.md")

if (mayHaveAddedProjects) {
    let diffUrl = "https://github.com/\(danger.github.pullRequest.fullName)/pull/\(danger.github.pullRequest.number)"
    let results = compatabilityTestAdditionsForUrl(diffUrl) ?? []
    for (repo, error) in results {
        #if os(Linux)
        let osName = "Linux"
        #else
        let osName = "macOS"
        #endif
        fail("\(repo.name) seems to be incompatible with \(osName): \(error)")
    }
}
